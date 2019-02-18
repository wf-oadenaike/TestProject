
CREATE VIEW [Access.ManyWho].[PADealingRequestRegisterVw]
	AS SELECT PADealingRequestRegisterId
		, RequestorPersonId
		, rp.FullEmployeeBK as RequestorSalesforceUserId
		, rp.PersonsName as RequestorPersonsName
		, RequestorRoleId
		, rr.RoleName as RequestorRoleName
		, RequestedDate
		, PADealingRequestStatus
		, OnStopList
		, InvestmentName
		, InvestmentType
		, PADealingTransactionTypeBK
		, WoodfordInvestmentYesNo
		, Value
		, EmployeeComments
		, ComplianceComments
		, ComplianceDecisionDate
		, CompliancePersonId
		, cp.FullEmployeeBK as ComplianceSalesforceUserId
		, cp.PersonsName as CompliancePersonsName
		, DocumentationFolderLink
		, WorkflowVersionGUID
		, JoinGUID
		, PADealingRequestCreationDatetime
		, PADealingRequestLastModifiedDatetime
	 FROM [Compliance].[PADealingRequestRegister] prr
		INNER JOIN Core.Persons rp
			ON prr.RequestorPersonId = rp.PersonId
		INNER JOIN Core.Roles rr
			ON prr.RequestorRoleId = rr.RoleId
		LEFT OUTER JOIN Core.Persons cp
			ON prr.CompliancePersonId = cp.PersonId
	 ;

GO

CREATE TRIGGER [Access.ManyWho].[PADealingRequestRegisterTri]
ON [Access.ManyWho].[PADealingRequestRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[PADealingRequestRegisterTri]';

	Declare @PADealingRegisterRst TABLE 
			( RstAction varchar(15), PADealingRequestRegisterId int, RequestorPersonId smallint, PADealingRequestStatus varchar(128), CompliancePersonId smallint,
			  DocumentationFolderLink varchar(2000), WorkflowVersionGUID uniqueidentifier, JoinGUID uniqueidentifier )
			;

	BEGIN TRANSACTION

	MERGE INTO [Compliance].[PADealingRequestRegister] prr
		USING (SELECT i.PADealingRequestRegisterId 
		        , rp.PersonId as RequestorPersonId
                , COALESCE( reqrp.RoleId, i.RequestorRoleId, -1) as RequestorRoleId
		, ISNULL (i.RequestedDate, GetDate()) as RequestedDate
		, (CASE WHEN i.PADealingRequestStatus IS NULL THEN 'AwaitingCompliance'
		        ELSE i.PADealingRequestStatus END) as PADealingRequestStatus
       	        , ISNULL (i.OnStopList, CAST (0 as bit)) as OnStopList
		, i.InvestmentName
		, i.InvestmentType
		, i.PADealingTransactionTypeBK
		, ISNULL (i.WoodfordInvestmentYesNo, CAST (0 as bit)) as WoodfordInvestmentYesNo
		, i.Value
		, i.EmployeeComments
		, i.ComplianceComments
		, (CASE WHEN i.PADealingRequestStatus IN ('Approved','Rejected') THEN GetDate() ELSE NULL END) as ComplianceDecisionDate
		, cp.PersonId as CompliancePersonId
                , i.DocumentationFolderLink
                , i.WorkflowVersionGUID
                , i.JoinGUID
		, GetDate() as PADealingRequestCreationDatetime
                , GetDate() as PADealingRequestLastModifiedDatetime
		FROM inserted i
			INNER JOIN Core.Persons rp
			ON i.RequestorSalesforceUserId = rp.FullEmployeeBK
			AND rp.ActiveFlag = 1
			LEFT OUTER JOIN Core.RolePersonRelationship reqrp
			ON rp.PersonId = reqrp.PersonId
			AND reqrp.ActiveFlag = 1
			LEFT OUTER JOIN Core.Persons cp
			ON i.ComplianceSalesforceUserId = cp.FullEmployeeBK
			AND cp.ActiveFlag = 1
					) Src
		ON (Src.PADealingRequestRegisterId IS NOT NULL AND prr.PADealingRequestRegisterId = Src.PADealingRequestRegisterId) 
		OR (prr.RequestorPersonId = Src.RequestorPersonId AND prr.RequestedDate = Src.RequestedDate)
		WHEN NOT MATCHED 
			THEN INSERT (RequestorPersonId, RequestorRoleId, RequestedDate, PADealingRequestStatus, OnStopList, InvestmentName, InvestmentType,
			 PADealingTransactionTypeBK,WoodfordInvestmentYesNo, Value, EmployeeComments, DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, PADealingRequestCreationDatetime, PADealingRequestLastModifiedDatetime)
				VALUES (Src.RequestorPersonId, Src.RequestorRoleId, Src.RequestedDate, Src.PADealingRequestStatus, Src.OnStopList, Src.InvestmentName, Src.InvestmentType,
                        Src.PADealingTransactionTypeBK, Src.WoodfordInvestmentYesNo, Src.Value, Src.EmployeeComments, Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, 
                        Src.PADealingRequestCreationDatetime, Src.PADealingRequestLastModifiedDatetime)
	   	WHEN MATCHED AND (prr.PADealingRequestStatus <> Src.PADealingRequestStatus
				OR prr.OnStopList <> Src.OnStopList
				OR prr.InvestmentName <> Src.InvestmentName
				OR prr.InvestmentType <> Src.InvestmentType
				OR prr.PADealingTransactionTypeBK <> Src.PADealingTransactionTypeBK
				OR prr.WoodfordInvestmentYesNo <> Src.WoodfordInvestmentYesNo
				OR (prr.Value IS NULL AND Src.Value IS NOT NULL)
				OR (prr.Value  IS NOT NULL AND Src.Value IS NULL)
				OR prr.Value <> Src.Value
				OR (prr.EmployeeComments IS NULL AND Src.EmployeeComments IS NOT NULL)
				OR (prr.EmployeeComments  IS NOT NULL AND Src.EmployeeComments IS NULL)
				OR prr.EmployeeComments <> Src.EmployeeComments
				OR (prr.ComplianceComments IS NULL AND Src.ComplianceComments IS NOT NULL)
				OR (prr.ComplianceComments  IS NOT NULL AND Src.ComplianceComments IS NULL)
				OR prr.ComplianceComments <> Src.ComplianceComments
				OR (prr.CompliancePersonId IS NULL AND Src.CompliancePersonId IS NOT NULL)
				OR (prr.CompliancePersonId  IS NOT NULL AND Src.CompliancePersonId IS NULL)
				OR prr.CompliancePersonId <> Src.CompliancePersonId				
				OR (prr.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
				OR (prr.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)
				OR prr.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET prr.PADealingRequestStatus = Src.PADealingRequestStatus
					, prr.OnStopList = Src.OnStopList
					, prr.InvestmentName = Src.InvestmentName
					, prr.InvestmentType = Src.InvestmentType
					, prr.PADealingTransactionTypeBK = Src.PADealingTransactionTypeBK
					, prr.WoodfordInvestmentYesNo = Src.WoodfordInvestmentYesNo
					, prr.Value = Src.Value
					, prr.EmployeeComments = Src.EmployeeComments
					, prr.ComplianceComments = Src.ComplianceComments
					, prr.CompliancePersonId = Src.CompliancePersonId
					, prr.ComplianceDecisionDate = Src.ComplianceDecisionDate
					, prr.DocumentationFolderLink = Src.DocumentationFolderLink
					, prr.PADealingRequestLastModifiedDatetime = Src.PADealingRequestLastModifiedDatetime
		OUTPUT $ACTION, INSERTED.PADealingRequestRegisterId, Src.RequestorPersonId, Src.PADealingRequestStatus,
                       Src.CompliancePersonId, Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID
			INTO @PADealingRegisterRst ( RstAction, PADealingRequestRegisterId, RequestorPersonId, PADealingRequestStatus, CompliancePersonId,
						 DocumentationFolderLink, WorkflowVersionGUID, JoinGUID )
			;

	-- create event record
	MERGE INTO [Compliance].[PADealingRequestEvents] pre
          USING ( SELECT rr.PADealingRequestRegisterId
               , CASE WHEN rr.RstAction = 'INSERT' THEN 'RequestSubmitted'
	   	      WHEN rr.RstAction = 'UPDATE' AND rr.PADealingRequestStatus = 'AwaitingRequestorUpdate' THEN 'ComplianceReview'
		      ELSE 'RequestAmended'
		 END as PADealingRequestEventType             
	       , COALESCE ( rr.CompliancePersonId, rr.RequestorPersonId, -1) as EventPersonId
	       , ISNULL((SELECT RoleId FROM [Core].[RolePersonRelationship] rpr WHERE rpr.ActiveFlag = 1
                 	AND ((rr.CompliancePersonId IS NULL AND rpr.PersonId = rr.RequestorPersonId) OR (rr.CompliancePersonId IS NOT NULL AND rpr.PersonId = rr.CompliancePersonId))),-1) as EventRoleId
	       , CASE WHEN rr.PADealingRequestStatus = 'Rejected' THEN 0
		      WHEN rr.PADealingRequestStatus = 'Approved' THEN 1
		      ELSE NULL 
		 END as EventTrueFalse
	       , GetDate () as EventDate
	       , rr.DocumentationFolderLink
	       , rr.WorkflowVersionGUID
	       , rr.JoinGUID
	       , GetDate () as PADealingRequestEventCreationDate
	       , GetDate () as PADealingRequestEventLastModifiedDate
	         FROM @PADealingRegisterRst rr) Src
	 ON Src.PADealingRequestRegisterId = pre.PADealingRequestRegisterId
	 AND Src.PADealingRequestEventType = pre.PADealingRequestEventType
	 WHEN NOT MATCHED 
		THEN INSERT (PADealingRequestRegisterId, PADealingRequestEventType, EventPersonId, EventRoleId, EventTrueFalse, EventDate
	                   , DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, PADealingRequestEventCreationDate, PADealingRequestEventLastModifiedDate)
		     VALUES (Src.PADealingRequestRegisterId, Src.PADealingRequestEventType, Src.EventPersonId, Src.EventRoleId, Src.EventTrueFalse, Src.EventDate
	                   , Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, Src.PADealingRequestEventCreationDate, Src.PADealingRequestEventLastModifiedDate)
	 WHEN MATCHED 
		THEN UPDATE SET   pre.EventPersonId = Src.EventPersonId
				, pre.EventRoleId = Src.EventRoleId
				, pre.EventTrueFalse = Src.EventTrueFalse
				, pre.DocumentationFolderLink = Src.DocumentationFolderLink
				, pre.EventDate = Src.EventDate
				, pre.PADealingRequestEventLastModifiedDate = Src.PADealingRequestEventLastModifiedDate
	;

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
