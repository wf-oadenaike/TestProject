CREATE VIEW [Access.ManyWho].[ProjectRegisterVw]
	AS SELECT ProjectRegisterId
				, ProjectNameBK
				, RequestorRoleId
				, rr.RoleName as RequestorRoleName
				, RequestorPersonId
				, rp.EmployeeBK as RequestorSalesforceUserId
				, rp.PersonsName as RequestorPersonsName
				, ProjectOwnerRoleId
				, por.RoleName as ProjectOwnerRoleName
				, ProjectOwnerPersonId
				, pop.EmployeeBK as ProjectOwnerSalesforceUserId
				, pop.PersonsName as ProjectOwnerPersonsName
				, OversightRoleId
				, osr.RoleName as OversightRoleName
				, OversightPersonId
				, osp.EmployeeBK as OversightSalesforceUserId
				, osp.PersonsName as OversigntPersonsName
				, RequestDate
				, ProposedStartDate
				, CONVERT(VARCHAR(10), ProposedStartDate, 103) AS ProposedStartDateString
				, EstimatedDuration
				, EstimatedDurationUnits
				, EstimatedDurationDays
				, EstimatedCost
				, TechnologyInvolved
				, ProjectApproved
				, (CASE WHEN ProjectApproved = 1 THEN 'Approved' WHEN ProjectApproved = 0 THEN 'Rejected' ELSE 'Under Review' END) AS [ProjectStatus]
				, StrategicProject
				, ProjectPurpose
				, ProjectScope
				, Dependences
				, ExternalResources
				, AdditionalDetails
				, DocumentationFolderLink
				, WorkflowVersionGUID
				, JoinGUID
				, ProjectCreationDate
				, ProjectLastModifiedDate
	 FROM [Organisation].[ProjectsRegister] pr
			INNER JOIN Core.Roles rr
				ON pr.RequestorRoleId = rr.RoleId
			INNER JOIN Core.Persons rp
				ON pr.RequestorPersonId = rp.PersonId
			INNER JOIN Core.Roles por
				ON pr.ProjectOwnerRoleId = por.RoleId
			INNER JOIN Core.Persons pop
				ON pr.ProjectOwnerPersonId = pop.PersonId
			INNER JOIN Core.Roles osr
				ON pr.OversightRoleId = osr.RoleId
			INNER JOIN Core.Persons osp
				ON pr.OversightPersonId = osp.PersonId
			INNER JOIN [Organisation].[ProjectMeasureUnits] pm
				ON pr.EstimatedDurationUnits = pm.MeasureUnitBK
	 ;

GO
CREATE TRIGGER [Access.ManyWho].[ProjectsRegisterTri]
ON [Access.ManyWho].[ProjectRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[ProjectsRegisterTri]';
	
	MERGE INTO [Organisation].[ProjectsRegister] pr
		USING (SELECT i.ProjectNameBK
                , COALESCE( reqrp.RoleId, i.RequestorRoleId, -1) as RequestorRoleId
			    , COALESCE( req.PersonId, i.RequestorPersonId, -1) as RequestorPersonId
                , COALESCE( prorp.RoleId, i.ProjectOwnerRoleId, -1) as ProjectOwnerRoleId
                , COALESCE( pro.PersonId, i.ProjectOwnerPersonId, -1) as ProjectOwnerPersonId
			    , COALESCE( ovrp.RoleId, i.ProjectOwnerRoleId, -1) as OversightRoleId
                , COALESCE( ov.PersonId, i.OversightPersonId, -1) as OversightPersonId
                , i.RequestDate
                , i.ProposedStartDate
                , i.EstimatedDuration
                , i.EstimatedDurationUnits
                , COALESCE( pmu.DaysEquivalent, 0) * i.EstimatedDuration as EstimatedDurationDays
                , i.EstimatedCost
                , i.TechnologyInvolved
                , i.ProjectApproved
		, i.StrategicProject
                , i.ProjectPurpose
                , i.ProjectScope
                , i.Dependences
                , i.ExternalResources
                , i.AdditionalDetails
                , i.DocumentationFolderLink
                , i.WorkflowVersionGUID
                , i.JoinGUID
		        , GetDate() as ProjectCreationDate
                , GetDate() as ProjectLastModifiedDate
				FROM inserted i
					LEFT OUTER JOIN Core.Persons req
					ON LEFT( i.RequestorSalesforceUserId, 15) = req.EmployeeBK
					AND req.ActiveFlag = 1
					LEFT OUTER JOIN Core.RolePersonRelationship reqrp
					ON req.PersonId = reqrp.PersonId
					AND reqrp.ActiveFlag = 1
					LEFT OUTER JOIN Core.Persons pro
					ON LEFT( i.ProjectOwnerSalesforceUserId, 15) = pro.EmployeeBK
					AND pro.ActiveFlag = 1
					LEFT OUTER JOIN Core.RolePersonRelationship prorp
					ON pro.PersonId = prorp.PersonId
					AND prorp.ActiveFlag = 1
					LEFT OUTER JOIN Core.Persons ov
					ON LEFT( i.OversightSalesforceUserId, 15) = ov.EmployeeBK
					AND ov.ActiveFlag = 1
					LEFT OUTER JOIN Core.RolePersonRelationship ovrp
					ON req.PersonId = ovrp.PersonId
					AND ovrp.ActiveFlag = 1
					LEFT OUTER JOIN Organisation.ProjectMeasureUnits pmu
					ON i.EstimatedDurationUnits = pmu.MeasureUnitBK
					) Src
		ON pr.JoinGUID = Src.JoinGUID
		WHEN NOT MATCHED 
			THEN INSERT (ProjectNameBK, RequestorRoleId, RequestorPersonId, ProjectOwnerRoleId, ProjectOwnerPersonId
						, OversightRoleId, OversightPersonId, RequestDate, ProposedStartDate, EstimatedDuration
                        , EstimatedDurationUnits, EstimatedDurationDays, EstimatedCost, TechnologyInvolved
                        , ProjectApproved, StrategicProject, ProjectPurpose, ProjectScope, Dependences, ExternalResources, AdditionalDetails
                        , DocumentationFolderLink, WorkflowVersionGUID, JoinGUID, ProjectCreationDate, ProjectLastModifiedDate)
				VALUES (Src.ProjectNameBK, Src.RequestorRoleId, Src.RequestorPersonId, Src.ProjectOwnerRoleId, Src.ProjectOwnerPersonId
						, Src.OversightRoleId, Src.OversightPersonId, Src.RequestDate, Src.ProposedStartDate, Src.EstimatedDuration
                        , Src.EstimatedDurationUnits, Src.EstimatedDurationDays, Src.EstimatedCost, Src.TechnologyInvolved
                        , Src.ProjectApproved, Src.StrategicProject, Src.ProjectPurpose, Src.ProjectScope, Src.Dependences, Src.ExternalResources, Src.AdditionalDetails
                        , Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID, Src.ProjectCreationDate, Src.ProjectLastModifiedDate)
		WHEN MATCHED AND (Pr.ProjectNameBK <> Src.ProjectNameBK
						OR Pr.RequestorRoleId <> Src.RequestorRoleId
						OR Pr.RequestorPersonId <> Src.RequestorPersonId
						OR Pr.ProjectOwnerRoleId <> Src.ProjectOwnerRoleId
						OR Pr.ProjectOwnerPersonId <> Src.ProjectOwnerPersonId
						OR Pr.OversightRoleId <> Src.OversightRoleId
						OR Pr.OversightPersonId <> Src.OversightPersonId
						OR Pr.RequestDate <> Src.RequestDate
						OR (Pr.ProposedStartDate IS NULL AND Src.ProposedStartDate IS NOT NULL)
						OR (Pr.ProposedStartDate IS NOT NULL AND Src.ProposedStartDate IS NULL)
						OR Pr.ProposedStartDate <> Src.ProposedStartDate
						OR (Pr.EstimatedDuration IS NULL AND Src.EstimatedDuration IS NOT NULL)
						OR (Pr.EstimatedDuration IS NOT NULL AND Src.EstimatedDuration IS NULL)
						OR Pr.EstimatedDuration <> Src.EstimatedDuration
						OR (Pr.EstimatedDurationUnits IS NULL AND Src.EstimatedDurationUnits IS NOT NULL)
						OR (Pr.EstimatedDurationUnits  IS NOT NULL AND Src.EstimatedDurationUnits IS NULL)
						OR Pr.EstimatedDurationUnits <> Src.EstimatedDurationUnits
						OR (Pr.EstimatedCost IS NULL AND Src.EstimatedCost IS NOT NULL)
						OR (Pr.EstimatedCost IS NOT NULL AND Src.EstimatedCost IS NULL)
						OR Pr.EstimatedCost <> Src.EstimatedCost
						OR Pr.TechnologyInvolved <> Src.TechnologyInvolved
						OR (Pr.ProjectApproved IS NULL AND Src.ProjectApproved IS NOT NULL)
						OR (Pr.ProjectApproved IS NOT NULL AND Src.ProjectApproved IS NULL)
						OR Pr.ProjectApproved <> Src.ProjectApproved
						OR (Pr.StrategicProject IS NULL AND Src.StrategicProject IS NOT NULL)
						OR (Pr.StrategicProject IS NOT NULL AND Src.StrategicProject IS NULL)
						OR Pr.StrategicProject <> Src.StrategicProject
						OR Pr.ProjectPurpose <> Src.ProjectPurpose
						OR Pr.ProjectScope <> Src.ProjectScope
						OR Pr.Dependences <> Src.Dependences
						OR (Pr.ExternalResources IS NULL AND Src.ExternalResources IS NOT NULL)
						OR (Pr.ExternalResources IS NOT NULL AND Src.ExternalResources IS NULL)
						OR Pr.ExternalResources <> Src.ExternalResources
						OR Pr.AdditionalDetails <> Src.AdditionalDetails
						OR (Pr.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
						OR (Pr.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)
						OR Pr.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET
						  Pr.ProjectNameBK = Src.ProjectNameBK 
						, Pr.RequestorRoleId = Src.RequestorRoleId
						, Pr.RequestorPersonId = Src.RequestorPersonId
						, Pr.ProjectOwnerRoleId = Src.ProjectOwnerRoleId
						, Pr.ProjectOwnerPersonId = Src.ProjectOwnerPersonId
						, Pr.OversightRoleId = Src.OversightRoleId
						, Pr.OversightPersonId = Src.OversightPersonId
						, Pr.RequestDate = Src.RequestDate
						, Pr.ProposedStartDate = Src.ProposedStartDate
						, Pr.EstimatedDuration = Src.EstimatedDuration
						, Pr.EstimatedDurationUnits = Src.EstimatedDurationUnits
						, Pr.EstimatedDurationDays = Src.EstimatedDurationDays
						, Pr.EstimatedCost = Src.EstimatedCost
						, Pr.TechnologyInvolved = Src.TechnologyInvolved
						, Pr.ProjectApproved = Src.ProjectApproved
						, Pr.StrategicProject = Src.StrategicProject
						, Pr.ProjectPurpose = Src.ProjectPurpose
						, Pr.ProjectScope = Src.ProjectScope
						, Pr.Dependences = Src.Dependences
						, Pr.ExternalResources = Src.ExternalResources
						, Pr.AdditionalDetails = Src.AdditionalDetails
						, Pr.DocumentationFolderLink = Src.DocumentationFolderLink
						, Pr.ProjectLastModifiedDate = Src.ProjectLastModifiedDate
			;

END TRY
BEGIN CATCH
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
