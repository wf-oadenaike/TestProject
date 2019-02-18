
CREATE view [Access.ManyWho].[PolicyThemeEventsVw]
	AS 
	SELECT pte.[PolicyThemeEventId], pte.[PolicyThemeRegisterId], ptpc.PTPCategoryName, ptr.[PolicyThemeNameBK], pte.[PolicyThemeEventTypeId], ptet.[PolicyThemeEventTypeBK]
		, pte.ReviewCollection, pte.PersonId, p.PersonsName, p.EmployeeBK as PersonSalesforceUserId, pte.RoleId, r.RoleName
		, pte.EventDetails, pte.EventDate, pte.EventTrueFalse
		, CASE WHEN pte.EventTrueFalse = 1 THEN 'Yes' WHEN pte.EventTrueFalse = 0 THEN 'No' ELSE NULL END as EventYesNo
		, pte.DocumentationFolderLink, pte.WorkflowVersionGUID, pte.JoinGUID
		, pte.[PolicyThemeEventCreationDatetime], [PolicyThemeEventLastModifiedDatetime]
	FROM [Organisation].[PolicyThemeEvents] pte
		INNER JOIN [Organisation].[PolicyThemeRegister] ptr
			ON pte.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
		INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
			ON ptr.PTPCategoryId = ptpc.PTPCategoryId
		INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
			ON pte.PolicyThemeEventTypeId = ptet.PolicyThemeEventTypeId
		INNER JOIN [Core].[Persons] p
			ON pte.PersonId = p.PersonId
		INNER JOIN [Core].[Roles] r
			ON pte.RoleId = r.RoleId
	;

GO

CREATE TRIGGER [Access.ManyWho].[PolicyThemeEventsVwTri]
ON [Access.ManyWho].[PolicyThemeEventsVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[PolicyThemeEventsVwTri]';

	DECLARE @EventsRst TABLE 
			( RstAction varchar(15), PolicyThemeRegisterId int, [PolicyThemeEventId] int, PolicyThemeEventTypeBK varchar(25)
			, ReviewCollection int, EventTrueFalse bit)
			;
	--SELECT * FROM inserted;

	BEGIN TRANSACTION

	PRINT N'Creating ad-hoc review event if change event'

	-- Create an 'Ad-Hoc Review' event record for 'Change' event if not initiated from 'Scheduled Review'
	-- and this has come from an INSERT not UPDATE (For an update will have deleted then inserted record so
	-- if nothing deleted this means insert).
	--
	-- This is so a new review cycle is started with a new ReviewCollection number.
	-- This ensures only updates happen on event records for the ReviewCollection and not for previous ones.
	INSERT INTO [Organisation].[PolicyThemeEvents] 
					([PolicyThemeRegisterId],[PolicyThemeEventTypeId],[ReviewCollection],[PersonId],[RoleId]
					, [EventDetails],[EventDate],[EventTrueFalse],[DocumentationFolderLink]
					, [WorkflowVersionGUID],[JoinGUID])
			 SELECT i.PolicyThemeRegisterId, COALESCE( ini.PolicyThemeEventTypeId, -1) as PolicyThemeEventTypeId
					, NEXT VALUE FOR [Organisation].[PolicyThemeEventCollectionSeq] as ReviewCollection
					 , COALESCE( i.PersonId, p.PersonId,  -1) as PersonId
					 , COALESCE( i.RoleId, r.RoleId, -1) as RoleId
					, i.EventDetails, i.EventDate, i.EventTrueFalse
					, i.DocumentationFolderLink
					, i.WorkflowVersionGUID, ISNULL( i.JoinGUID, ptr.JoinGUID) as JoinGUID
				FROM INSERTED i
					INNER JOIN [Organisation].[PolicyThemeRegister] ptr
						ON i.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
					INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
						ON i.PolicyThemeEventTypeId = ptet.PolicyThemeEventTypeId
					INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
						ON ptr.PTPCategoryId = ptpc.PTPCategoryId
					LEFT OUTER JOIN Core.Persons p
						ON LEFT( i.PersonSalesforceUserId, 15) = p.EmployeeBK
						AND p.ActiveFlag = 1
					LEFT OUTER JOIN Core.Roles r
						ON i.RoleName = r.RoleName
						LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
							ON r.RoleId = rpr.RoleId
							AND p.PersonId = rpr.PersonId
							AND rpr.ActiveFlag = 1
					LEFT OUTER JOIN (	SELECT pte2.PolicyThemeRegisterId
											, MAX( pte2.PolicyThemeEventCreationDatetime) as LastSignOff
										FROM [Organisation].[PolicyThemeEvents] pte2
										INNER JOIN [Organisation].[PolicyThemeEventTypes] ptpc2
											ON pte2.PolicyThemeEventTypeId = ptpc2.PolicyThemeEventTypeId
										WHERE ptpc2.PolicyThemeEventTypeBK IN ('ReviewSignedOff')
										GROUP BY pte2.PolicyThemeRegisterId
									) lso
						ON lso.PolicyThemeRegisterId = i.PolicyThemeRegisterId
					LEFT OUTER JOIN (	SELECT pte3.PolicyThemeRegisterId
											, MAX( pte3.PolicyThemeEventCreationDatetime) as LastReview
										FROM [Organisation].[PolicyThemeEvents] pte3
										INNER JOIN [Organisation].[PolicyThemeEventTypes] ptpc3
											ON pte3.PolicyThemeEventTypeId = ptpc3.PolicyThemeEventTypeId
										WHERE ptpc3.PolicyThemeEventTypeBK IN ('Change')
										GROUP BY pte3.PolicyThemeRegisterId
									) lr
						ON lr.PolicyThemeRegisterId = i.PolicyThemeRegisterId
						AND ( lr.LastReview > lso.LastSignOff
						OR lso.LastSignOff is NULL)
					LEFT OUTER JOIN ( SELECT PolicyThemeRegisterId, MAX( PolicyThemeEventId) AS LastPolicyThemeEventId
											, MAX(CASE WHEN PolicyThemeEventTypeBK = 'Scheduled Review' AND EventTrueFalse IS NULL THEN PolicyThemeEventId ELSE 0 END) AS LastSchRevEventId
									  FROM [Organisation].[PolicyThemeEvents] e
										INNER JOIN [Organisation].[PolicyThemeEventTypes] et
											ON e.PolicyThemeEventTypeId = et.PolicyThemeEventTypeId
									  GROUP BY PolicyThemeRegisterId
									) LastE
							ON 	LastE.PolicyThemeRegisterId = i.PolicyThemeRegisterId
					CROSS JOIN [Organisation].[PolicyThemeEventTypes] ini
				WHERE ptet.PolicyThemeEventTypeBK = 'Change'
				AND ini.PolicyThemeEventTypeBK = 'AD-Hoc Review'
				AND (LastE.LastPolicyThemeEventId <> LastSchRevEventId OR LastE.PolicyThemeRegisterId IS NULL)
				AND NOT EXISTS (SELECT * FROM DELETED)
		;


	--PRINT N'Creating new Scheduled Review event'

	-- Create Scheduled Review event
	-- if latest 'collection' event is not 'Scheduled Review' with EventTrueFalse not set (NULL)
	-- and not come from an UPDATE
		INSERT INTO [Organisation].[PolicyThemeEvents] 
					([PolicyThemeRegisterId],[PolicyThemeEventTypeId],[ReviewCollection],[PersonId],[RoleId]
					, [EventDetails],[EventDate],[EventTrueFalse],[DocumentationFolderLink]
					, [WorkflowVersionGUID],[JoinGUID])
			 SELECT i.PolicyThemeRegisterId, COALESCE( i.PolicyThemeEventTypeId, -1) as PolicyThemeEventTypeId
					, NEXT VALUE FOR [Organisation].[PolicyThemeEventCollectionSeq] as ReviewCollection
					 , COALESCE( i.PersonId, p.PersonId,  -1) as PersonId
					 , COALESCE( i.RoleId, r.RoleId, -1) as RoleId
					, i.EventDetails, i.EventDate, i.EventTrueFalse
					, i.DocumentationFolderLink
					, i.WorkflowVersionGUID, ISNULL( i.JoinGUID, ptr.JoinGUID) as JoinGUID
				FROM INSERTED i
					INNER JOIN [Organisation].[PolicyThemeRegister] ptr
						ON i.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
					INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
						ON i.PolicyThemeEventTypeId = ptet.PolicyThemeEventTypeId
					INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
						ON ptr.PTPCategoryId = ptpc.PTPCategoryId
					LEFT OUTER JOIN Core.Persons p
						ON LEFT( i.PersonSalesforceUserId, 15) = p.EmployeeBK
						AND p.ActiveFlag = 1
					LEFT OUTER JOIN Core.Roles r
						ON i.RoleName = r.RoleName
						LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
							ON r.RoleId = rpr.RoleId
							AND p.PersonId = rpr.PersonId
							AND rpr.ActiveFlag = 1
					LEFT OUTER JOIN ( SELECT e.PolicyThemeRegisterId, MAX( ReviewCollection) AS LastReviewCollection
											, MAX(CASE WHEN PolicyThemeEventTypeBK = 'Scheduled Review' AND EventTrueFalse IS NULL THEN ReviewCollection ELSE 0 END) AS LastSchReviewCollection
									  FROM [Organisation].[PolicyThemeEvents] e
										INNER JOIN [Organisation].[PolicyThemeEventTypes] et
											ON e.PolicyThemeEventTypeId = et.PolicyThemeEventTypeId
									  GROUP BY e.PolicyThemeRegisterId
									) LastE
					ON 	LastE.PolicyThemeRegisterId = i.PolicyThemeRegisterId
				WHERE ptet.PolicyThemeEventTypeBK = 'Scheduled Review'
				AND (LastE.LastReviewCollection <> LastE.LastSchReviewCollection OR LastE.LastReviewCollection IS NULL)
				AND NOT EXISTS (SELECT * FROM DELETED)
	;


	-- PRINT N'Main event update'

/*
	-- try insert dummy record

	INSERT INTO [Organisation].[PolicyThemeEvents] ([PolicyThemeRegisterId],[PolicyThemeEventTypeId],[PersonId],[RoleId]
					, [EventDetails],[EventDate],[EventTrueFalse],[DocumentationFolderLink]
					, [WorkflowVersionGUID],[JoinGUID])
	SELECT	  i.[PolicyThemeRegisterId]
	        , i.[PolicyThemeEventTypeId]
		    , -1 -- ISNULL(i.[PersonId],-1)
			, -1 -- ISNULL(i.[RoleId],-1)
			, i.[EventDetails]
		    , i.[EventDate]
		    , i.[EventTrueFalse]
		    , i.[DocumentationFolderLink]
		    , i.[WorkflowVersionGUID]
			, i.[JoinGUID]	
	FROM INSERTED i;
*/

	--Main event update
	-- added logic to only update the latest event record for RegisterId/EventTypeId/PersonId/latest ReviewCollection
	MERGE INTO [Organisation].[PolicyThemeEvents] Tar
	USING (     SELECT i.PolicyThemeRegisterId 
					 , (SELECT MAX(pte2.ReviewCollection) 
					    FROM [Organisation].[PolicyThemeEvents] pte2
						WHERE pte2.PolicyThemeRegisterId = i.PolicyThemeRegisterId) as ReviewCollection
					 , ptet.PolicyThemeEventTypeBK
					 , COALESCE( i.PolicyThemeEventTypeId,  ptet.PolicyThemeEventTypeId, -1) as PolicyThemeEventTypeId
					 , COALESCE( i.PersonId, p.PersonId,  -1) as PersonId
					 , COALESCE( i.RoleId, r.RoleId, -1) as RoleId
					 , i.EventDetails
					 , i.EventDate
				     , i.EventTrueFalse
					 , i.DocumentationFolderLink
					 , i.WorkflowVersionGUID
					 , ISNULL( i.JoinGUID, ptr.JoinGUID) as JoinGUID
				FROM INSERTED i
				INNER JOIN [Organisation].[PolicyThemeRegister] ptr
					ON i.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
				INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
					ON i.PolicyThemeEventTypeId = ptet.PolicyThemeEventTypeId
				INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
					ON ptr.PTPCategoryId = ptpc.PTPCategoryId
				LEFT OUTER JOIN Core.Persons p
					ON LEFT( i.PersonSalesforceUserId, 15) = p.EmployeeBK
					AND p.ActiveFlag = 1
				LEFT OUTER JOIN Core.Roles r
					ON i.RoleName = r.RoleName
				LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
					ON r.RoleId = rpr.RoleId
					AND p.PersonId = rpr.PersonId
					AND rpr.ActiveFlag = 1
				LEFT OUTER JOIN (SELECT [PolicyThemeRegisterId]
									  , [PolicyThemeEventTypeId]
									  , [PersonId]
				                      , MAX(ReviewCollection) LatestReviewCollection
				                 FROM [Organisation].[PolicyThemeEvents]
								 GROUP BY [PolicyThemeRegisterId]
								        , [PolicyThemeEventTypeId]
									    , [PersonId]) pte
				ON i.PolicyThemeRegisterId = pte.PolicyThemeRegisterId
				AND ptet.PolicyThemeEventTypeID = pte.[PolicyThemeEventTypeId]
				AND ISNULL(p.PersonId,-1) = pte.[PersonId]
				AND i.ReviewCollection = pte.LatestReviewCollection
				WHERE (pte.LatestReviewCollection IS NOT NULL AND i.ReviewCollection IS NOT NULL)
				OR (pte.LatestReviewCollection IS NULL AND i.ReviewCollection IS NULL)
			) Src
	ON Tar.PolicyThemeRegisterId = Src.PolicyThemeRegisterId
	AND Tar.PolicyThemeEventTypeId = Src.PolicyThemeEventTypeId
	AND Tar.ReviewCollection = Src.ReviewCollection
	AND Tar.PersonId = Src.PersonId
	WHEN NOT MATCHED THEN
		INSERT ([PolicyThemeRegisterId],[PolicyThemeEventTypeId],[ReviewCollection],[PersonId],[RoleId]
					, [EventDetails],[EventDate],[EventTrueFalse],[DocumentationFolderLink]
					, [WorkflowVersionGUID],[JoinGUID])
		VALUES (	  Src.[PolicyThemeRegisterId], Src.[PolicyThemeEventTypeId]
					, Src.[ReviewCollection]
					, Src.[PersonId], Src.[RoleId], Src.[EventDetails], Src.[EventDate], Src.[EventTrueFalse]
					, Src.[DocumentationFolderLink], Src.[WorkflowVersionGUID], Src.[JoinGUID]
	
					)
	WHEN MATCHED THEN 
	UPDATE		SET [EventDetails] = ISNULL (Src.[EventDetails], Tar.[EventDetails])
					,[EventDate] = ISNULL( Src.[EventDate], Tar.[EventDate])
					,[EventTrueFalse] = ISNULL( Src.[EventTrueFalse], Tar.[EventTrueFalse])
					,[DocumentationFolderLink] = ISNULL(Src.[DocumentationFolderLink], Tar.[DocumentationFolderLink])
					,[PolicyThemeEventLastModifiedDatetime] = GetDate()
	OUTPUT $ACTION, INSERTED.PolicyThemeRegisterId, INSERTED.PolicyThemeEventId, Src.PolicyThemeEventTypeBK, Src.ReviewCollection, Src.EventTrueFalse
	INTO @EventsRst( RstAction, PolicyThemeRegisterId, [PolicyThemeEventId], PolicyThemeEventTypeBK, ReviewCollection, EventTrueFalse)
		;

	--Select * from @EventsRst;

	--PRINT N'Create Review SignOff event for signatories'
	
	-- create 'ReviewSignedOff' Event if all signaturies are true. (EventTrueFalse)
	-- if 'ReviewSignedOff' event already exists for this review cycle (ie same ReviewCollection number), the lastmodifiedDatetime
	-- is updated so this event record becomes the last updated record for this ReviewCollection and the Document Status on the
	-- register can be correctly updated if a signatory event is switched between TrueFalse statuses.
	MERGE INTO Organisation.PolicyThemeEvents Tar
	USING ( SELECT r.[PolicyThemeRegisterId], e.[PolicyThemeEventTypeId], r.[ReviewCollection]
						, GetDate() as [EventDate], -1 as [PersonId], -1 as [RoleId]
						, ptr.[WorkflowVersionGUID], ptr.[JoinGUID]
			FROM  @EventsRst r
			INNER JOIN (
						SELECT p.PolicyThemeRegisterId
						FROM Organisation.PolicyThemeEvents p
						INNER JOIN (
									SELECT p.PolicyThemeRegisterId, MAX( p.ReviewCollection) as LastReviewCollection
									FROM Organisation.PolicyThemeEvents p 
									GROUP BY p.PolicyThemeRegisterId
									) rst
						ON p.PolicyThemeRegisterId = rst.PolicyThemeRegisterId
						AND p.ReviewCollection = rst.LastReviewCollection
						INNER JOIN Organisation.PolicyThemeEventTypes e
						ON p.PolicyThemeEventTypeId = e.PolicyThemeEventTypeId
						WHERE e.PolicyThemeEventTypeBK = 'Signatory'
						GROUP BY p.PolicyThemeRegisterId
						HAVING SUM( CASE p.[EventTrueFalse] WHEN 1 THEN 1 ELSE 0 END) = COUNT(*)
						AND SUM( CASE p.[EventTrueFalse] WHEN 1 THEN 0 ELSE 1 END) = 0
					  ) so
				ON r.PolicyThemeRegisterId = so.PolicyThemeRegisterId
			INNER JOIN [Organisation].[PolicyThemeRegister] ptr
				ON r.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
			CROSS JOIN Organisation.PolicyThemeEventTypes e
			WHERE e.PolicyThemeEventTypeBK = 'ReviewSignedOff'
			) Src
	ON Tar.PolicyThemeRegisterId = Src.PolicyThemeRegisterId
	AND Tar.PolicyThemeEventTypeId = Src.PolicyThemeEventTypeId
	AND Tar.ReviewCollection = Src.ReviewCollection
	AND Tar.PersonId = Src.PersonId
	WHEN NOT MATCHED THEN 
		INSERT ([PolicyThemeRegisterId], [PolicyThemeEventTypeId], [ReviewCollection]
			, EventDate, PersonId, RoleId, WorkflowVersionGUID, JoinGUID)
			VALUES (Src.[PolicyThemeRegisterId], Src.[PolicyThemeEventTypeId], Src.[ReviewCollection]
			, Src.EventDate, Src.PersonId, Src.RoleId, Src.WorkflowVersionGUID, Src.JoinGUID)
	WHEN MATCHED THEN
		UPDATE SET [PolicyThemeEventLastModifiedDatetime] = GetDate()
				;

	--PRINT N'Create Review SignOff event for Scheduled Review'

	-- create 'ReviewSignedOff' Event if latest event is 'Scheduled Review' with EventTrueFalse of true.
	MERGE INTO Organisation.PolicyThemeEvents Tar
	USING ( SELECT r.[PolicyThemeRegisterId]
	             , (SELECT e.[PolicyThemeEventTypeId]
				    FROM Organisation.PolicyThemeEventTypes e
					WHERE e.PolicyThemeEventTypeBK = 'ReviewSignedOff') as [PolicyThemeEventTypeId]
				 , r.[ReviewCollection]
				 , GetDate() as [EventDate]
				 , -1 as [PersonId]
				 , -1 as [RoleId]
				 , ptr.[WorkflowVersionGUID]
				 , ptr.[JoinGUID]
			FROM  @EventsRst r
			INNER JOIN [Organisation].[PolicyThemeRegister] ptr
				ON r.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
			WHERE r.PolicyThemeEventTypeBK = 'Scheduled Review'
			AND r.EventTrueFalse = 1
			) Src
	ON Tar.PolicyThemeRegisterId = Src.PolicyThemeRegisterId
	AND Tar.PolicyThemeEventTypeId = Src.PolicyThemeEventTypeId
	AND Tar.ReviewCollection = Src.ReviewCollection
	AND Tar.PersonId = Src.PersonId
	WHEN NOT MATCHED THEN 
		INSERT ([PolicyThemeRegisterId], [PolicyThemeEventTypeId], [ReviewCollection]
			, EventDate, PersonId, RoleId, WorkflowVersionGUID, JoinGUID)
			VALUES (Src.[PolicyThemeRegisterId], Src.[PolicyThemeEventTypeId], Src.[ReviewCollection]
			, Src.EventDate, Src.PersonId, Src.RoleId, Src.WorkflowVersionGUID, Src.JoinGUID)
	WHEN MATCHED THEN
		UPDATE SET  [PolicyThemeEventLastModifiedDatetime] = GetDate()
				;

	-- update 'change' record for latest collection if eventTrueFalse is NULL
	-- if 'ReviewSignedOff' event exists set to 1
    -- if any signatory records with EventTrueFalse set to 0, set to 0
    UPDATE pte
	SET pte.EventTrueFalse=1
	FROM Organisation.PolicyThemeEvents pte
	INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
	ON pte.[PolicyThemeEventTypeId] = ptet.[PolicyThemeEventTypeId]
	WHERE ptet.PolicyThemeEventTypeBK = 'Change'
	AND pte.EventTrueFalse IS NULL
	AND pte.ReviewCollection = (SELECT MAX(pte2.ReviewCollection) 
	                        FROM Organisation.PolicyThemeEvents pte2
							WHERE pte.PolicyThemeRegisterId = pte2.PolicyThemeRegisterId)
	AND EXISTS ( SELECT 1
	             FROM Organisation.PolicyThemeEvents pte2
				 INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet2
				 ON pte2.[PolicyThemeEventTypeId] = ptet2.[PolicyThemeEventTypeId]
				 WHERE pte.PolicyThemeRegisterId = pte2.PolicyThemeRegisterId
				 AND ptet2.PolicyThemeEventTypeBK = 'ReviewSignedOff'
				 AND pte2.ReviewCollection = pte.ReviewCollection)
							
	;

    UPDATE pte
	SET pte.EventTrueFalse=0
	FROM Organisation.PolicyThemeEvents pte
	INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet
	ON pte.[PolicyThemeEventTypeId] = ptet.[PolicyThemeEventTypeId]
	WHERE ptet.PolicyThemeEventTypeBK = 'Change'
	AND pte.EventTrueFalse IS NULL
	AND pte.ReviewCollection = (SELECT MAX(pte2.ReviewCollection) 
	                        FROM Organisation.PolicyThemeEvents pte2
							WHERE pte.PolicyThemeRegisterId = pte2.PolicyThemeRegisterId)
	AND EXISTS ( SELECT 1
	             FROM Organisation.PolicyThemeEvents pte2
				 INNER JOIN [Organisation].[PolicyThemeEventTypes] ptet2
				 ON pte2.[PolicyThemeEventTypeId] = ptet2.[PolicyThemeEventTypeId]
				 WHERE pte.PolicyThemeRegisterId = pte2.PolicyThemeRegisterId
				 AND ptet2.PolicyThemeEventTypeBK = 'Signatory'
				 AND pte2.EventTrueFalse=0
				 AND pte2.ReviewCollection = pte.ReviewCollection)
							
	;	

	--  Update PolicyThemeRegister DocumentStatus based on latest event created.
	--  change status is now obsolete and not used
			UPDATE ptr
			SET ptr.PolicyThemeDocumentStatus = CASE  
													WHEN e.PolicyThemeEventTypeBK = 'AD-Hoc Review' THEN 'Under Review'
													WHEN e.PolicyThemeEventTypeBK = 'Change' THEN 'Under Review'
													WHEN e.PolicyThemeEventTypeBK = 'Scheduled Review' AND pte.EventTrueFalse IS NULL THEN 'Under Review'
													WHEN e.PolicyThemeEventTypeBK = 'Signatory' AND pte.EventTrueFalse = 0 THEN 'Under Review'
													WHEN e.PolicyThemeEventTypeBK = 'Signatory' AND pte.EventTrueFalse IS NULL THEN 'Under Review'
													WHEN e.PolicyThemeEventTypeBK = 'ReviewSignedOff'  THEN 'Approved'
													ELSE ptr.PolicyThemeDocumentStatus
												   END
				, ptr.PolicyThemeExpiryDate = CASE e.PolicyThemeEventTypeBK 
												WHEN 'ReviewSignedOff' THEN CASE WHEN ptrf.[frequency] = 'yy' THEN dateadd(yy,ptrf.[ValidityPeriod],GetDate())
									                                             WHEN ptrf.[frequency] = 'q' THEN dateadd(q,ptrf.[ValidityPeriod],GetDate())
									                                             WHEN ptrf.[frequency] = 'm' THEN dateadd(m,ptrf.[ValidityPeriod],GetDate())
									                                        ELSE dateadd(yy,ptrf.[ValidityPeriod],GetDate()) END
												ELSE ptr.PolicyThemeExpiryDate
											  END
				, ptr.PolicyThemeLastModifiedDatetime = GetDate()
			FROM [Organisation].[PolicyThemeRegister] ptr
			INNER JOIN @EventsRst r
				ON ptr.PolicyThemeRegisterId = r.PolicyThemeRegisterId
			INNER JOIN [Organisation].[PolicyThemeReviewFrequencies] ptrf
			    ON ptrf.PolicyThemeReviewFrequencyId = ptr.PolicyThemeReviewFrequencyId
			INNER JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
				ON ptpc.PTPCategoryId = ptr.PTPCategoryId
			INNER JOIN [Organisation].[PolicyThemeEvents] pte
				ON pte.PolicyThemeRegisterId = ptr.PolicyThemeRegisterId
			INNER JOIN Organisation.PolicyThemeEventTypes e
				ON pte.PolicyThemeEventTypeId = e.PolicyThemeEventTypeId
			INNER JOIN (	SELECT p.PolicyThemeRegisterId
								,MAX( p.ReviewCollection) as LastReviewCollection
								,MAX(p.PolicyThemeEventLastModifiedDatetime) as Latestrecord
							FROM Organisation.PolicyThemeEvents p
							GROUP BY p.PolicyThemeRegisterId
							) rst
				ON pte.PolicyThemeRegisterId = rst.PolicyThemeRegisterId
				AND pte.ReviewCollection = rst.LastReviewCollection
				and pte.PolicyThemeEventLastModifiedDatetime = rst.Latestrecord
			WHERE r.RstAction IN ('INSERT','UPDATE')
			;	

			
  -- ensure all changed register items have an entry in the scheduler WorkflowLaunchList for next review date (annual review)			
  -- merge entries into WorkflowLaunchList
  
  -- if there is an already existing future review date, update this with new date

  MERGE INTO [Scheduler].[WorkflowLaunchList] wfll
  USING ( SELECT   pr.[PolicyThemeRegisterId]
                 , DATEADD(d,ptrf.[ReviewWithin]*-1,[PolicyThemeExpiryDate]) as NextReviewDate
	             , (SELECT [FlowId] FROM [Scheduler].[Workflows] WHERE [FlowName] = 'Policy & Procedures') as FlowId
				 , 'PolicyThemeRegisterId:' + CAST(pr.[PolicyThemeRegisterId] as varchar) as LaunchRef
          FROM @EventsRst r
		  INNER JOIN [Organisation].[PolicyThemeRegister] pr
		  ON r.PolicyThemeRegisterId = pr.PolicyThemeRegisterId 
		  INNER JOIN [Organisation].[PolicyThemeReviewFrequencies] ptrf
		  ON ptrf.PolicyThemeReviewFrequencyId = pr.PolicyThemeReviewFrequencyId		  
          INNER JOIN [Organisation].[PolicyThemeProcedures] pp
          on pp.[PolicyThemeRegisterId] = pr.[PolicyThemeRegisterId]
          INNER JOIN [Organisation].[PolicyThemeProcedureCategories] pc
          ON pp.[PTPCategoryId] = pc.[PTPCategoryId]
          AND pc.[PTPRegisterLevel] = 1
          WHERE pr.[PolicyThemeDocumentStatus]='Approved'
          AND pr.[ActiveFlag] = 1
		  AND r.RstAction IN ('INSERT','UPDATE')
		) Src
  ON wfll.[FlowId] = Src.[FlowId]
  --AND wfll.[LaunchDate] > GetDate () -- only for future reviews
  AND wfll.[LaunchRef] = Src.LaunchRef
  WHEN NOT MATCHED THEN 
		INSERT ([FlowId],[LaunchDate],[LaunchRef],[IsActive],[CreatedDate])
		VALUES (Src.[FlowId], Src.[NextReviewDate], Src.LaunchRef, 1, GetDate() )
	WHEN MATCHED THEN
		UPDATE SET [LaunchDate] = Src.NextReviewDate
		         , [IsActive]=1
				;

  -- merge entries into WorkflowParameters
  MERGE INTO [Scheduler].[WorkflowParameters] wfp
  USING ( SELECT wfll.[WorkflowLaunchId]
               , 'Scheduler ID' as KeyName
		       , p.[PolicyThemeRegisterId] as Value
			   , 'ContentNumber' as ContentType
		  FROM (SELECT  pr.[PolicyThemeRegisterId]
                      , DATEADD(d,ptrf.[ReviewWithin]*-1,[PolicyThemeExpiryDate]) as NextReviewDate
	                  , (SELECT [FlowId] FROM [Scheduler].[Workflows] WHERE [FlowName] = 'Policy & Procedures') as FlowId
				      , 'PolicyThemeRegisterId:' + CAST(pr.[PolicyThemeRegisterId] as varchar) as LaunchRef 
                FROM @EventsRst r
		        INNER JOIN [Organisation].[PolicyThemeRegister] pr
		        ON r.PolicyThemeRegisterId = pr.PolicyThemeRegisterId 
				INNER JOIN [Organisation].[PolicyThemeReviewFrequencies] ptrf
		        ON ptrf.PolicyThemeReviewFrequencyId = pr.PolicyThemeReviewFrequencyId
                INNER JOIN [Organisation].[PolicyThemeProcedures] pp
                ON pp.[PolicyThemeRegisterId] = pr.[PolicyThemeRegisterId]
                INNER JOIN [Organisation].[PolicyThemeProcedureCategories] pc
                ON pp.[PTPCategoryId] = pc.[PTPCategoryId]
                AND pc.[PTPRegisterLevel] = 1
                WHERE pr.[PolicyThemeDocumentStatus]='Approved'
                AND pr.[ActiveFlag] = 1
				AND r.RstAction IN ('INSERT','UPDATE')) p
		  INNER JOIN [Scheduler].[WorkflowLaunchList] wfll
          ON wfll.[FlowId] = p.[FlowId]
          --AND wfll.[LaunchDate] > GetDate ()
          AND wfll.[LaunchRef] = p.LaunchRef
		) Src
  ON wfp.[WorkflowLaunchId] = Src.[WorkflowLaunchId]
  AND wfp.[Value] = Src.[Value]
  WHEN NOT MATCHED THEN 
		INSERT ([WorkflowLaunchId],[Key],[Value],[ContentType])
		VALUES (Src.[WorkflowLaunchId], Src.[KeyName], Src.[Value], Src.[ContentType] )
				;
			
	COMMIT;
END TRY
BEGIN CATCH

		ROLLBACk;

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
