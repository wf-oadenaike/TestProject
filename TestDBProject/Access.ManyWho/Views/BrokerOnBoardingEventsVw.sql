CREATE VIEW [Access.ManyWho].[BrokerOnBoardingEventsVw]
	AS
	SELECT  be.BrokerOnBoardingEventId
	      , be.BrokerOnBoardingRegisterId
		  , be.BrokerOnBoardingEventTypeId
		  , bet.BrokerOnBoardingEventTypeBK
		  , be.ReviewCollection
		  , p.PersonsName
          , p.EmployeeBK as PersonSalesforceUserId
		  , be.PersonId
		  , r.RoleName
		  , be.RoleId
		  , d.DepartmentName
		  , be.DepartmentId
		  , be.EventDetails
		  , be.EventDate
		  , be.EventTrueFalse
		  , be.DocumentationFolderLink 
		  , be.WorkflowVersionGUID
		  , be.JoinGUID
		  , be.BrokerOnBoardingEventCreationDatetime
		  , be.BrokerOnBoardingEventLastModifiedDatetime
	FROM  [Organisation].[BrokerOnBoardingEvents] be
		INNER JOIN [Organisation].[BrokerOnBoardingEventTypes] bet
			ON (be.BrokerOnBoardingEventTypeId = bet.BrokerOnBoardingEventTypeId)
		LEFT OUTER JOIN Core.Persons p
			ON be.PersonId = p.PersonId
			AND p.ActiveFlag = 1
		LEFT OUTER JOIN Core.Roles r
			ON be.RoleId = r.RoleId
			AND r.ActiveFlag = 1
		LEFT OUTER JOIN Core.Departments d
			ON d.DepartmentId = be.DepartmentId
			AND d.ActiveFlag = 1
	;

GO
CREATE TRIGGER [Access.ManyWho].[BrokerOnBoardingEventsTri]
ON [Access.ManyWho].[BrokerOnBoardingEventsVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[BrokerOnBoardingEventsTri]';
	
	DECLARE @NextReviewCollection	INTEGER;

	DECLARE @EventsRst TABLE 
			( RstAction varchar(15), BrokerOnBoardingRegisterId int, BrokerOnBoardingEventId int, BrokerOnBoardingEventTypeId Smallint
			, ReviewCollection int--BrokerOnBoardingEventTypeBK varchar(25)
			);
			--SELECT * FROM inserted;
BEGIN TRANSACTION

    -- retrieve next collection sequence if required
    SELECT @NextReviewCollection = NEXT VALUE FOR [Organisation].[BrokerOnBoardingCollectionSeq]
	FROM inserted i
	INNER JOIN Organisation.BrokerOnBoardingRegister BR
		ON   i.BrokerOnBoardingRegisterId =   BR.BrokerOnBoardingRegisterId
		OR (i.JoinGUID = BR.JoinGUID AND  i.BrokerOnBoardingRegisterId IS NULL)
	LEFT OUTER JOIN ( 
					SELECT  BrokerOnBoardingRegisterId
					      , MAX(ReviewCollection) AS LastReviewCollection
					FROM [Organisation].[BrokerOnBoardingEvents]
					GROUP BY BrokerOnBoardingRegisterId
							) LRC
	ON br.BrokerOnBoardingRegisterId = LRC.BrokerOnBoardingRegisterId
	WHERE LRC.LastReviewCollection IS NULL
	OR BR.BrokerOnBoardingStatus IN ('Approved','Rejected','Expired','Authorised for Single Use')
	;

	-- Main block event update
	MERGE INTO [Organisation].[BrokerOnBoardingEvents] Tar
		USING (SELECT 
				    ISNULL(i.BrokerOnBoardingRegisterId, BR.BrokerOnBoardingRegisterId)		AS BrokerOnBoardingRegisterId
				  , ISNULL(i.BrokerOnBoardingEventTypeId, BET.BrokerOnBoardingEventTypeId)	AS BrokerOnBoardingEventTypeId
				  , LRC.LastReviewCollection
				  , COALESCE( i.PersonId, pa.PersonId, -1) as PersonId
				  , COALESCE( i.RoleId, pa.AssignedRoleId, -1) as RoleId
				  , COALESCE( i.DepartmentId, pa.DepartmentId, -1) AS DepartmentId
				  ,i.EventDetails
				  ,i.EventDate
				  ,i.EventTrueFalse
				  ,i.DocumentationFolderLink
				  ,i.WorkflowVersionGUID
				  , ISNULL( i.JoinGUID, BR.JoinGUID) AS JoinGUID
				  , GETDATE() AS BrokerOnBoardingEventCreationDatetime
				  , GETDATE() AS BrokerOnBoardingEventLastModifiedDatetime
				FROM inserted i
				INNER JOIN Organisation.BrokerOnBoardingRegister BR
					ON   i.BrokerOnBoardingRegisterId =   BR.BrokerOnBoardingRegisterId
					OR (i.JoinGUID = BR.JoinGUID AND  i.BrokerOnBoardingRegisterId IS NULL)
				LEFT OUTER JOIN [Organisation].[BrokerOnBoardingEventTypes] BET
					ON (i.BrokerOnBoardingEventTypeBK = BET.BrokerOnBoardingEventTypeBK)
				LEFT OUTER JOIN [Access.ManyWho].[PersonsActiveVw] pa
					ON LEFT( i.PersonSalesforceUserId, 15) = pa.EmployeeBK

				LEFT OUTER JOIN ( 
							SELECT 
								BrokerOnBoardingRegisterId
								, MAX(ReviewCollection) AS LastReviewCollection
							FROM [Organisation].[BrokerOnBoardingEvents]
							GROUP BY BrokerOnBoardingRegisterId
							) LRC
					ON i.BrokerOnBoardingRegisterId = LRC.BrokerOnBoardingRegisterId
				) Src
		ON (Tar.BrokerOnBoardingRegisterId = Src.BrokerOnBoardingRegisterId
		AND Tar.BrokerOnBoardingEventTypeId = Src.BrokerOnBoardingEventTypeId
		AND Tar.PersonId = Src.PersonId
		AND	Tar.ReviewCollection = Src.LastReviewCollection
		)
		WHEN NOT MATCHED 
			THEN INSERT (  BrokerOnBoardingRegisterId
						  ,BrokerOnBoardingEventTypeId
						  ,ReviewCollection
						  ,PersonId
						  ,RoleId
						  ,DepartmentId
						  ,EventDetails
						  ,EventDate
						  ,EventTrueFalse
						  ,DocumentationFolderLink
						  ,WorkflowVersionGUID
						  ,JoinGUID
						 )
				VALUES (	
						    Src.BrokerOnBoardingRegisterId
						  , Src.BrokerOnBoardingEventTypeId
						  , ISNULL(@NextReviewCollection,Src.LastReviewCollection)
						  , Src.PersonId
						  , Src.RoleId
						  , Src.DepartmentId
						  , Src.EventDetails
						  , Src.EventDate
						  , Src.EventTrueFalse
						  , Src.DocumentationFolderLink
						  , Src.WorkflowVersionGUID
						  , Src.JoinGUID
						 )
		WHEN MATCHED AND (   (Tar.EventDetails IS NULL AND Src.EventDetails IS NOT NULL)
		                    OR (Tar.EventDetails IS NOT NULL AND Src.EventDetails IS NULL)
		                    OR (Tar.EventDate IS NULL AND Src.EventDate IS NOT NULL)
		                    OR (Tar.EventDate IS NOT NULL AND Src.EventDate IS NULL)
							OR (Tar.EventTrueFalse IS NULL AND Src.EventTrueFalse IS NOT NULL)
							OR (Tar.EventTrueFalse IS NOT NULL AND Src.EventTrueFalse IS NULL)
							OR Tar.EventDetails <> Src.EventDetails
							OR Tar.EventDate <> Src.EventDate
							OR Tar.EventTrueFalse <> Src.EventTrueFalse
							OR Tar.DocumentationFolderLink <> Src.DocumentationFolderLink
							OR Tar.RoleId <> Src.RoleId
							OR Tar.DepartmentId <> Src.DepartmentId
						)
		THEN UPDATE SET   
						  Tar.EventDetails = Src.EventDetails
						, Tar.EventDate = Src.EventDate
						, Tar.EventTrueFalse = Src.EventTrueFalse
						, Tar.DocumentationFolderLink = Src.DocumentationFolderLink
						, Tar.BrokerOnBoardingEventLastModifiedDatetime = Src.BrokerOnBoardingEventLastModifiedDatetime
						, Tar.RoleId = Src.RoleId
						, Tar.DepartmentId = Src.DepartmentId
		OUTPUT $ACTION, INSERTED.BrokerOnBoardingRegisterId, INSERTED.BrokerOnBoardingEventId, Src.BrokerOnBoardingEventTypeId, ISNULL(@NextReviewCollection,Src.LastReviewCollection)
		INTO @EventsRst( RstAction, BrokerOnBoardingRegisterId, BrokerOnBoardingEventId , BrokerOnBoardingEventTypeId, ReviewCollection);
		
	
			--  Update the Register status
			UPDATE BR
				SET BR.[BrokerOnBoardingStatus] = CASE 
													WHEN BET.BrokerOnBoardingEventTypeBK = 'Form Sent'		THEN 'Pending Broker Response'
													WHEN BET.BrokerOnBoardingEventTypeBK = 'Form Received'	THEN 'Pending Review'
													WHEN BET.BrokerOnBoardingEventTypeBK = 'Broker Review' 
													     AND BBE.EventTrueFalse IS NULL                     THEN 'Under Review'
													WHEN BET.BrokerOnBoardingEventTypeBK = 'Broker Review' 
													     AND BBE.EventTrueFalse = 0                         THEN 'Rejected'    
													WHEN BET.BrokerOnBoardingEventTypeBK = 'BERC Review'    THEN 'Under Review'
													ELSE BR.[BrokerOnBoardingStatus]
												  END
			FROM [Organisation].[BrokerOnBoardingRegister] BR
			INNER JOIN Organisation.BrokerOnBoardingEvents BBE
				ON BBE.BrokerOnBoardingRegisterId = BR.BrokerOnBoardingRegisterId 
			INNER JOIN @EventsRst VT
			    ON BR.[BrokerOnBoardingRegisterId] = VT.BrokerOnBoardingRegisterId
				AND BBE.BrokerOnBoardingEventId = VT.BrokerOnBoardingEventId
			INNER JOIN [Organisation].[BrokerOnBoardingEventTypes] BET
				ON BET.BrokerOnBoardingEventTypeId = BBE.BrokerOnBoardingEventTypeId
			WHERE VT.RstAction IN ('INSERT','UPDATE')
			AND BET.BrokerOnBoardingEventTypeBK IN ('Form Sent','Form Received','Broker Review', 'BERC Review' );
			
		-- Update the head register when all signators have been set to true for Broker Review
				UPDATE BR
					SET BR.[BrokerOnBoardingStatus] = CASE 
														WHEN BR.OneTimeUse = 1	THEN 'Authorised for Single Use'
														WHEN BR.OneTimeUse = 0	THEN 'Pending BERC Approval'
														WHEN GETDATE()>BR.ExpectedDateUse AND BR.OneTimeUse =1	THEN 'Expired'
														ELSE 'Rejected'
													 END
				
				FROM [Organisation].[BrokerOnBoardingRegister] BR
				INNER JOIN @EventsRst VT
					ON BR.[BrokerOnBoardingRegisterId] = VT.BrokerOnBoardingRegisterId
				INNER JOIN [Organisation].[BrokerOnBoardingEventTypes] BET
					ON BET.BrokerOnBoardingEventTypeId = VT.BrokerOnBoardingEventTypeId
				INNER JOIN (	
							SELECT p.BrokerOnBoardingRegisterId
							FROM Organisation.BrokerOnBoardingEvents p
							INNER JOIN (
										SELECT 
											p.BrokerOnBoardingRegisterId
										, MAX( p.ReviewCollection) AS LastReviewCollection
										FROM Organisation.BrokerOnBoardingEvents p 
										GROUP BY p.BrokerOnBoardingRegisterId
										) rst
							ON p.BrokerOnBoardingRegisterId = rst.BrokerOnBoardingRegisterId
							AND p.ReviewCollection = rst.LastReviewCollection
							INNER JOIN [Organisation].[BrokerOnBoardingEventTypes] e
								ON p.BrokerOnBoardingEventTypeId = e.BrokerOnBoardingEventTypeId
							WHERE e.BrokerOnBoardingEventTypeBK= 'Broker Review'
							GROUP BY p.BrokerOnBoardingRegisterId
							HAVING SUM( CASE p.[EventTrueFalse] WHEN 1 THEN 1 ELSE 0 END) = COUNT(*)
							AND SUM( CASE p.[EventTrueFalse] WHEN 1 THEN 0 ELSE 1 END) = 0
							) so
				ON VT.[BrokerOnBoardingRegisterId] = SO.BrokerOnBoardingRegisterId
				WHERE VT.RstAction IN ('INSERT','UPDATE')
                AND BET.BrokerOnBoardingEventTypeBK = 'Broker Review';				
		
		
				-- Update the head register for Berc Review
		
				UPDATE BR
					SET BR.[BrokerOnBoardingStatus] = CASE 
														WHEN BBE.EventTrueFalse = 1 AND BR.OneTimeUse =0	THEN 'Approved'
														WHEN GETDATE()>BR.ExpectedDateUse AND BR.OneTimeUse =1	THEN 'Expired'
													   	WHEN BBE.EventTrueFalse = 0 THEN 'Rejected'
														ELSE  BR.[BrokerOnBoardingStatus] 
													   END
				FROM [Organisation].[BrokerOnBoardingRegister] BR
				INNER JOIN @EventsRst VT
					ON BR.[BrokerOnBoardingRegisterId] = VT.BrokerOnBoardingRegisterId
				INNER JOIN [Organisation].[BrokerOnBoardingEventTypes] BET
					ON BET.BrokerOnBoardingEventTypeId = VT.BrokerOnBoardingEventTypeId
				INNER JOIN Organisation.BrokerOnBoardingEvents BBE
					ON BBE.BrokerOnBoardingRegisterId = BR.BrokerOnBoardingRegisterId 

				INNER JOIN (	
						SELECT 
						 p.BrokerOnBoardingRegisterId
						, MAX( p.ReviewCollection) AS LastReviewCollection
						FROM Organisation.BrokerOnBoardingEvents p 
						GROUP BY p.BrokerOnBoardingRegisterId
						) so
				ON VT.[BrokerOnBoardingRegisterId] = SO.BrokerOnBoardingRegisterId
				AND BBE.ReviewCollection = so.LastReviewCollection
				WHERE VT.RstAction IN ('INSERT','UPDATE')
				AND BET.BrokerOnBoardingEventTypeBK= 'BERC Review';
			
	COMMIT;
									
END TRY
BEGIN CATCH
ROLLBACK;
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;
		 
		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strTriggerName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
END CATCH
;
