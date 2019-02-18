CREATE VIEW [Access.ManyWho].[ProjectAspectVw]
	AS SELECT pa.ProjectAspectId
				, pa.ProjectRegisterId
				, pa.ProjectAspectTypeId
				, pat.ProjectAspectTypeBK 
				, pa.Costs
				, pa.PersonId
				, p.EmployeeBK as PersonSalesforceUserId
				, p.PersonsName as PersonsName
				, pa.RoleId
				, r.RoleName
				, pa.DepartmentId
				, d.DepartmentName
				, pa.AspectDetails
				, pa.AspectDate
				, pa.AspectTrueFalse
				, (CASE WHEN pa.AspectTrueFalse = 1 THEN 'Approved' WHEN pa.AspectTrueFalse = 0 THEN 'Rejected' ELSE 'Under Review' END) AS AspectStatus
				, pa.DocumentationFolderLink
				, pa.WorkflowVersionGUID
				, pa.JoinGUID
				, pa.ProjectAspectCreationDatetime
				, pa.ProjectAspectLastModifiedDatetime
		FROM [Organisation].[ProjectAspects] pa
				INNER JOIN Organisation.ProjectAspectTypes pat
					ON pa.ProjectAspectTypeId = pat.ProjectAspectTypeId
				LEFT OUTER JOIN Core.Persons p
					ON pa.PersonId = p.PersonId
				LEFT OUTER JOIN Core.Roles r
					ON pa.RoleId = r.RoleId
				LEFT OUTER JOIN Core.Departments d
					ON pa.DepartmentId = d.DepartmentId

GO
CREATE TRIGGER [Access.ManyWho].[ProjectAspectsTri]
ON [Access.ManyWho].[ProjectAspectVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	Declare	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[ProjectAspectsTri]';

	Declare @AspectsRst TABLE 
			( RstAction varchar(15), [ProjectRegisterId] smallint, [ProjectAspectId] smallint, [ProjectAspectTypeBK] varchar(25)
			, [AspectTrueFalse] bit)
			;

	BEGIN TRANSACTION

	MERGE INTO [Organisation].[ProjectAspects] pa
		USING (SELECT ISNULL( i.ProjectRegisterId, pr.ProjectRegisterId) as ProjectRegisterId
					, pat.ProjectAspectTypeId
					, pat.ProjectAspectTypeBK
					, i.Costs
                    , COALESCE( i.PersonId, p.PersonId, pe.PersonId, -1) as PersonId
					, COALESCE( i.RoleId, r.RoleId, -1) as RoleId
					, COALESCE( i.DepartmentId, d.DepartmentId, -1) as DepartmentId
					, i.AspectDetails
					, i.AspectDate
					, i.AspectTrueFalse
					, i.DocumentationFolderLink
					, ISNULL( i.WorkflowVersionGUID, pr.WorkflowVersionGUID) as WorkflowVersionGUID
					, ISNULL( i.JoinGUID, pr.JoinGUID) as JoinGUID
					, GetDate() as ProjectAspectCreationDatetime
					, GetDate() as ProjectAspectLastModifiedDatetime
				FROM inserted i
				INNER JOIN Organisation.ProjectsRegister pr
					ON i.ProjectRegisterId = pr.ProjectRegisterId
					OR (i.JoinGUID = pr.JoinGUID and i.ProjectRegisterId IS NULL)
				INNER JOIN Organisation.ProjectAspectTypes pat
					ON i.ProjectAspectTypeBK = pat.ProjectAspectTypeBK
                LEFT OUTER JOIN Core.Persons p
					ON LEFT( i.PersonSalesforceUserId, 15) = p.EmployeeBK
					AND p.ActiveFlag = 1
                LEFT OUTER JOIN Core.Persons pe
					ON i.PersonsName = pe.PersonsName
					AND pe.ActiveFlag = 1
				LEFT OUTER JOIN Core.Roles r
				    ON i.RoleName = r.RoleName
					AND r.ActiveFlag = 1
				LEFT OUTER JOIN Core.Departments d
				    ON i.DepartmentName = d.DepartmentName
					AND d.ActiveFlag = 1
				) Src
		ON (pa.ProjectRegisterId = src.ProjectRegisterId
		AND pa.ProjectAspectTypeId = Src.ProjectAspectTypeId
		AND pa.PersonId = Src.PersonId
		AND pa.RoleId = Src.RoleId
		AND pa.DepartmentId = Src.DepartmentId)
		WHEN NOT MATCHED 
			THEN INSERT (ProjectRegisterId, ProjectAspectTypeId, Costs, PersonId, RoleId
			            , DepartmentId, AspectDetails, AspectDate, AspectTrueFalse
						, DocumentationFolderLink, WorkflowVersionGUID, JoinGUID
						, ProjectAspectCreationDatetime, ProjectAspectLastModifiedDatetime)
				VALUES (Src.ProjectRegisterId, Src.ProjectAspectTypeId, Src.Costs, Src.PersonId, Src.RoleId
			            , Src.DepartmentId, Src.AspectDetails, Src.AspectDate, Src.AspectTrueFalse
						, Src.DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID
						, Src.ProjectAspectCreationDatetime, Src.ProjectAspectLastModifiedDatetime)
		WHEN MATCHED AND ((pa.Costs IS NULL AND Src.Costs IS NOT NULL)
						OR (pa.Costs IS NOT NULL AND Src.Costs IS NULL)
		                OR pa.Costs <> Src.Costs
						OR (pa.AspectDetails IS NULL AND Src.AspectDetails IS NOT NULL)
						OR (pa.AspectDetails IS NOT NULL AND Src.AspectDetails IS NULL)
						OR pa.AspectDetails <> Src.AspectDetails
						OR (pa.AspectDate IS NULL AND Src.AspectDate IS NOT NULL)
						OR (pa.AspectDate IS NOT NULL AND Src.AspectDate IS NULL)
						OR pa.AspectDate <> Src.AspectDate
						OR (pa.AspectTrueFalse IS NULL AND Src.AspectTrueFalse IS NOT NULL)
						OR (pa.AspectTrueFalse IS NOT NULL AND Src.AspectTrueFalse IS NULL)
						OR pa.AspectTrueFalse <> Src.AspectTrueFalse
						OR (pa.DocumentationFolderLink IS NULL AND Src.DocumentationFolderLink IS NOT NULL)
						OR (pa.DocumentationFolderLink IS NOT NULL AND Src.DocumentationFolderLink IS NULL)
						OR pa.DocumentationFolderLink <> Src.DocumentationFolderLink)
			THEN UPDATE SET pa.Costs = Src.Costs
						  , pa.AspectDetails = Src.AspectDetails
						  , pa.AspectDate = Src.AspectDate
						  , pa.AspectTrueFalse = Src.AspectTrueFalse
						  , pa.DocumentationFolderLink = Src.DocumentationFolderLink
						  , pa.ProjectAspectLastModifiedDatetime = Src.ProjectAspectLastModifiedDatetime
		OUTPUT $ACTION, INSERTED.ProjectRegisterId, INSERTED.ProjectAspectId, Src.ProjectAspectTypeBK, Src.AspectTrueFalse
			INTO @AspectsRst( RstAction, ProjectRegisterId, ProjectAspectId, ProjectAspectTypeBK, AspectTrueFalse)
			;	

	-- Update the project register when all approvers have been set to true
	UPDATE pr
			SET  pr.ProjectApproved= 1 
			FROM [Organisation].[ProjectsRegister] pr
				INNER JOIN @AspectsRst r
					ON pr.ProjectRegisterId = r.ProjectRegisterId
				INNER JOIN (SELECT pa.ProjectRegisterId
							FROM Organisation.ProjectAspects pa
								INNER JOIN Organisation.ProjectAspectTypes pat
									ON pa.ProjectAspectTypeId = pat.ProjectAspectTypeId
							WHERE pat.ProjectAspectTypeBK = 'Approver'
							GROUP BY pa.ProjectRegisterId
							HAVING SUM( CASE pa.[AspectTrueFalse] WHEN 1 THEN 1 ELSE 0 END) = COUNT(*)
							AND SUM( CASE pa.[AspectTrueFalse] WHEN 1 THEN 0 ELSE 1 END) = 0) so
					ON r.ProjectRegisterId = so.ProjectRegisterId
			WHERE r.RstAction = 'UPDATE'
			AND r.ProjectAspectTypeBK = 'Approver'
			AND ISNULL(r.AspectTrueFalse,0) = 1
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
