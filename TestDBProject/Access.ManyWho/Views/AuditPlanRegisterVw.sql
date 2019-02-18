
CREATE VIEW [Access.ManyWho].[AuditPlanRegisterVw]
	AS SELECT AuditPlanRegisterId
		, AuditNameBK
		, AuditType
		, AuditCreationDate
		, AuditYear
		, AuditPlanStatus
 		, OwnerPersonId
		, op.EmployeeBK as OwnerSalesforceUserId
		, op.PersonsName as OwnerPersonsName
		, OwnerRoleId
		, owr.RoleName as OwnerRoleName
		, ProcessCoverage
		, AuditRationale
		, EstimatedDuration
		, ExpectedStartDate
		, AuditFindings
		, AuditRecommendations
		, AuditActions
		, EscalationYesNo
		, JIRAEpicKey
		, DocumentationFolderLink
		, WorkflowVersionGUID
		, JoinGUID
		, AuditPlanCreationDatetime
		, AuditPlanLastModifiedDatetime
	 FROM [Internal.Audit].[AuditPlanRegister] apr
		INNER JOIN Core.Persons op
			ON apr.OwnerPersonId = op.PersonId
		INNER JOIN Core.Roles owr
			ON apr.OwnerRoleId = owr.RoleId
	 ;

GO

CREATE TRIGGER [Access.ManyWho].[AuditPlanRegisterTri]
ON [Access.ManyWho].[AuditPlanRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[AuditPlanRegisterTri]';

	Declare @AuditPlanRegisterRst TABLE 
			( RstAction varchar(15), AuditPlanRegisterId int, OwnerPersonId smallint, OwnerRoleId smallint, AuditPlanStatus varchar(128),
			  DocumentationFolderLink varchar(2000), WorkflowVersionGUID uniqueidentifier, JoinGUID uniqueidentifier )
			;

	BEGIN TRANSACTION

	MERGE INTO [Internal.Audit].[AuditPlanRegister] apr
		USING (SELECT i.AuditPlanRegisterId 
		, i.AuditNameBK
		, i.AuditType
		, ISNULL (i.AuditCreationDate, GetDate()) as AuditCreationDate
		, YEAR (ISNULL(i.ExpectedStartDate, GetDate())) as AuditYear
		, ISNULL (i.AuditPlanStatus, 'Scheduled') AuditPlanStatus
		, op.PersonId as OwnerPersonId
                , COALESCE( ownrp.RoleId, i.OwnerRoleId, -1) as OwnerRoleId
		, i.ProcessCoverage
		, i.AuditRationale
		, i.EstimatedDuration
		, i.ExpectedStartDate
		, i.AuditFindings
		, i.AuditRecommendations
		, i.AuditActions
		, i.EscalationYesNo
		, i.JIRAEpicKey
      	, i.DocumentationFolderLink
        , i.WorkflowVersionGUID
        , i.JoinGUID
		, GetDate() as AuditPlanCreationDatetime
                , GetDate() as AuditPlanLastModifiedDatetime
		FROM inserted i
			INNER JOIN Core.Persons op
			ON LEFT( i.OwnerSalesforceUserId, 15) = op.EmployeeBK
			AND op.ActiveFlag = 1
			LEFT OUTER JOIN Core.RolePersonRelationship ownrp
			ON op.PersonId = ownrp.PersonId
			AND ownrp.ActiveFlag = 1
					) Src
		ON apr.AuditNameBK = Src.AuditNameBK
		WHEN NOT MATCHED 
			THEN INSERT (AuditNameBK, AuditType, AuditCreationDate, AuditYear, AuditPlanStatus, OwnerPersonId, OwnerRoleId, ProcessCoverage, AuditRationale, EstimatedDuration
			 , ExpectedStartDate, AuditFindings, AuditRecommendations, AuditActions, EscalationYesNo, JIRAEpicKey
                         , DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, AuditPlanCreationDatetime, AuditPlanLastModifiedDatetime)
				VALUES (Src.AuditNameBK, Src.AuditType, Src.AuditCreationDate, Src.AuditYear, Src.AuditPlanStatus, Src.OwnerPersonId, Src.OwnerRoleId, Src.ProcessCoverage, Src.AuditRationale, Src.EstimatedDuration
			       	, Src.ExpectedStartDate, Src.AuditFindings, Src.AuditRecommendations, Src.AuditActions, Src.EscalationYesNo, Src.JIRAEpicKey
                         	, Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, Src.AuditPlanCreationDatetime, Src.AuditPlanLastModifiedDatetime)
	   	WHEN MATCHED AND (apr.AuditYear <> Src.AuditYear
				OR apr.AuditType <> Src.AuditType
				OR apr.AuditPlanStatus <> Src.AuditPlanStatus
				OR apr.OwnerPersonId <> Src.OwnerPersonId
				OR apr.OwnerRoleId <> Src.OwnerRoleId
				OR apr.ProcessCoverage <> Src.ProcessCoverage
				OR apr.AuditRationale <> Src.AuditRationale
				OR apr.EstimatedDuration <> Src.EstimatedDuration
				OR apr.ExpectedStartDate <> Src.ExpectedStartDate
				OR (apr.AuditFindings IS NULL AND Src.AuditFindings IS NOT NULL)
				OR (apr.AuditFindings IS NOT NULL AND Src.AuditFindings IS NULL)
				OR apr.AuditFindings <> Src.AuditFindings
				OR (apr.AuditRecommendations IS NULL AND Src.AuditRecommendations IS NOT NULL)
				OR (apr.AuditRecommendations IS NOT NULL AND Src.AuditRecommendations IS NULL)
				OR apr.AuditRecommendations <> Src.AuditRecommendations
				OR (apr.AuditActions IS NULL AND Src.AuditActions IS NOT NULL)
				OR (apr.AuditActions IS NOT NULL AND Src.AuditActions IS NULL)
				OR apr.AuditActions <> Src.AuditActions
				OR (apr.EscalationYesNo IS NULL AND Src.EscalationYesNo IS NOT NULL)
				OR (apr.EscalationYesNo IS NOT NULL AND Src.EscalationYesNo IS NULL)
				OR apr.EscalationYesNo <> Src.EscalationYesNo
				OR (apr.JIRAEpicKey IS NULL AND Src.JIRAEpicKey IS NOT NULL)
				OR (apr.JIRAEpicKey IS NOT NULL AND Src.JIRAEpicKey IS NULL)
				OR apr.JIRAEpicKey <> Src.JIRAEpicKey
				OR (apr.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
				OR (apr.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)
				OR apr.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET apr.AuditType = Src.AuditType
					, apr.AuditYear = Src.AuditYear
					, apr.AuditPlanStatus = Src.AuditPlanStatus
					, apr.OwnerPersonId = Src.OwnerPersonId
					, apr.OwnerRoleId = Src.OwnerRoleId
					, apr.ProcessCoverage = Src.ProcessCoverage
					, apr.AuditRationale = Src.AuditRationale
					, apr.EstimatedDuration = Src.EstimatedDuration
					, apr.ExpectedStartDate = Src.ExpectedStartDate
					, apr.AuditFindings = Src.AuditFindings
					, apr.AuditRecommendations = Src.AuditRecommendations
					, apr.AuditActions = Src.AuditActions
					, apr.EscalationYesNo = Src.EscalationYesNo
					, apr.JIRAEpicKey = Src.JIRAEpicKey
					, apr.DocumentationFolderLink = Src.DocumentationFolderLink
					, apr.AuditPlanLastModifiedDatetime = Src.AuditPlanLastModifiedDatetime
		OUTPUT $ACTION, INSERTED.AuditPlanRegisterId, Src.OwnerPersonId, SRC.OwnerRoleId, Src.AuditPlanStatus,
                        Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID
			INTO @AuditPlanRegisterRst ( RstAction, AuditPlanRegisterId, OwnerPersonId, OwnerRoleId, AuditPlanStatus,
						 DocumentationFolderLink, WorkflowVersionGUID, JoinGUID )
			;

	-- create event record
	MERGE INTO [Internal.Audit].[AuditPlanEvents] ape 
          USING ( SELECT rr.AuditPlanRegisterId
               , CASE WHEN rr.RstAction = 'INSERT' THEN 'AuditPlanCreated' 
	   	      WHEN rr.RstAction = 'UPDATE' AND rr.AuditPlanStatus = 'Completed' THEN 'AuditPlanCompleted'
		      ELSE 'AuditPlanUpdated'
		 END as AuditPlanEventType             
	       , rr.OwnerPersonId as EventPersonId
	       , rr.OwnerRoleId as EventRoleId
	       , CASE WHEN rr.AuditPlanStatus = 'Completed' THEN 1
		      ELSE 0 
		 END as EventTrueFalse
	       , GetDate () as EventDate
	       , rr.DocumentationFolderLink
	       , rr.WorkflowVersionGUID
	       , rr.JoinGUID
	       , GetDate () as AuditPlanEventCreationDate
	       , GetDate () as AuditPlanEventLastModifiedDate
	         FROM @AuditPlanRegisterRst rr) Src
	 ON Src.AuditPlanRegisterId = ape.AuditPlanRegisterId
	 AND Src.AuditPlanEventType = ape.AuditPlanEventType
	 WHEN NOT MATCHED 
		THEN INSERT (AuditPlanRegisterId, AuditPlanEventType, EventPersonId, EventRoleId, EventTrueFalse, EventDate
	                   , DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, AuditPlanEventCreationDate, AuditPlanEventLastModifiedDate)
		     VALUES (Src.AuditPlanRegisterId, Src.AuditPlanEventType, Src.EventPersonId, Src.EventRoleId, Src.EventTrueFalse, Src.EventDate
	                   , Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, Src.AuditPlanEventCreationDate, Src.AuditPlanEventLastModifiedDate)
	 WHEN MATCHED 
		THEN UPDATE SET   ape.EventPersonId = Src.EventPersonId
				, ape.EventRoleId = Src.EventRoleId
				, ape.EventTrueFalse = Src.EventTrueFalse
				, ape.DocumentationFolderLink = Src.DocumentationFolderLink
				, ape.EventDate = Src.EventDate
				, ape.AuditPlanEventLastModifiedDate = Src.AuditPlanEventLastModifiedDate
	;
	
  -- ensure all changed register items have an entry in the scheduler WorkflowLaunchList for next audit date		
  -- merge entries into WorkflowLaunchList
  -- if there is an already existing future audit date, update this with new date
  
  MERGE INTO [Scheduler].[WorkflowLaunchList] wfll
  USING ( SELECT   apr.[AuditPlanRegisterId]
                 , DATEADD(d,-21,apr.[ExpectedStartDate]) as NextAuditDate
	             , (SELECT [FlowId] FROM [Scheduler].[Workflows] WHERE [FlowName] = 'Internal Audit') as FlowId
				 , 'AuditPlanRegisterId:' + CAST(apr.[AuditPlanRegisterId] as varchar) as LaunchRef
          FROM @AuditPlanRegisterRst r
		  INNER JOIN [Internal.Audit].[AuditPlanRegister] apr
		  ON r.AuditPlanRegisterId = apr.AuditPlanRegisterId
          WHERE apr.[AuditPlanStatus]='Scheduled'
		  AND r.RstAction IN ('INSERT','UPDATE')
		) Src
  ON wfll.[FlowId] = Src.[FlowId]
  AND wfll.[LaunchRef] = Src.LaunchRef
  WHEN NOT MATCHED THEN 
		INSERT ([FlowId],[LaunchDate],[LaunchRef],[IsActive],[CreatedDate])
		VALUES (Src.[FlowId], Src.[NextAuditDate], Src.LaunchRef, 1, GetDate() )
	WHEN MATCHED THEN
		UPDATE SET [LaunchDate] = Src.NextAuditDate
		         , [IsActive]=1
				;

  --select * from @AuditPlanRegisterRst;

  --select * from [Scheduler].[WorkflowLaunchList] where [FlowId] = 'A6C54E76-49A0-479D-AC12-053585195286';

  -- merge entries into WorkflowParameters
  MERGE INTO [Scheduler].[WorkflowParameters] wfp
  USING ( SELECT wfll.[WorkflowLaunchId]
               , 'Scheduler ID' as KeyName
		       , p.[AuditPlanRegisterId] as Value
			   , 'ContentNumber' as ContentType
		  FROM (SELECT  apr.[AuditPlanRegisterId]
					, DATEADD(d,-21,apr.[ExpectedStartDate]) as NextAuditDate
					, (SELECT [FlowId] FROM [Scheduler].[Workflows] WHERE [FlowName] = 'Internal Audit') as FlowId
					, 'AuditPlanRegisterId:' + CAST(apr.[AuditPlanRegisterId] as varchar) as LaunchRef
                FROM @AuditPlanRegisterRst r
				INNER JOIN [Internal.Audit].[AuditPlanRegister] apr
				ON r.AuditPlanRegisterId = apr.AuditPlanRegisterId
				WHERE apr.[AuditPlanStatus]='Scheduled'
				AND r.RstAction IN ('INSERT','UPDATE')) p
		  INNER JOIN [Scheduler].[WorkflowLaunchList] wfll
          ON wfll.[FlowId] = p.[FlowId]
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
