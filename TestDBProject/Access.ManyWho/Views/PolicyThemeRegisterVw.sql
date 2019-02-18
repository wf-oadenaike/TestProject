CREATE VIEW [Access.ManyWho].[PolicyThemeRegisterVw]
	AS 
	SELECT ptr.PolicyThemeRegisterId, ptr.PTPCategoryId, ptpc.PTPCategoryBK
			, ptp.PolicyThemeProcedureNameBK AS PolicyThemeNameBK, sod.SignOffDate as SignOffDate
			, ptprr.RoleId as PolicyThemeOwnerRoleId, r.RoleName AS PolicyThemeOwnerRoleName
			, ISNULL( rp.PersonId, -1) as CurrentAssignedOwnerPersonId, ISNULL( rp.EmployeeBK, 'UNKNOWN') as CurrentAssignedOwnerSalesforceUserId
			, ISNULL( rp.PersonsName, 'UNKNOWN') as CurrentAssignedOwnerPersonsName
			, ptr.PolicyThemeVersionNo, ptr.PolicyThemeExpiryDate, ptr.PolicyThemeDocumentStatus, ptr.ActiveFlag
			, ptr.ChangeStatus, ptr.ChangeReason, ptr.PolicyThemeSummary
			, ptrf.ReviewFrequencyName
			, ptr.DocumentationFolderLink
			, ptr.WorkflowVersionGUID, ptr.JoinGUID
			, ptr.PolicyThemeCreationDatetime, ptr.PolicyThemeLastModifiedDatetime
	FROM [Organisation].[PolicyThemeRegister] ptr
	    INNER JOIN [Organisation].[PolicyThemeReviewFrequencies] ptrf
		    ON ptr.PolicyThemeReviewFrequencyId = ptrf.PolicyThemeReviewFrequencyId
		INNER JOIN Organisation.PolicyThemeProcedureCategories ptpc
			ON ptr.PTPCategoryId = ptpc.PTPCategoryId
		INNER JOIN [Organisation].[PolicyThemeProcedures] ptp
			ON ptr.[PolicyThemeRegisterId] = ptp.[PolicyThemeRegisterId]
			AND ptpc.PTPCategoryId = ptp.PTPCategoryId
			AND ptpc.PTPRegisterLevel = 1 --True
			AND ptp.ActiveFlag = 1 --True
		INNER JOIN [Organisation].[PolicyThemeProcedureRoleRelationship] ptprr
			ON ptp.PolicyThemeProcedureId = ptprr.PolicyThemeProcedureId
			AND ptprr.PolicyThemeProcedureOwner = 1 --True
		INNER JOIN [Core].[Roles] r
			ON ptprr.RoleId = r.RoleId
			AND r.ActiveFlag = 1
			LEFT OUTER JOIN [Core].[RolePersonRelationship] rpr
				ON r.RoleId = rpr.RoleId
				AND rpr.ActiveFlag = 1
				INNER JOIN [Core].[Persons] rp
					ON rpr.PersonId = rp.PersonId
					AND rp.ActiveFlag = 1
		LEFT OUTER JOIN ( SELECT pte.PolicyThemeRegisterId, Cast( MAX(pte.[PolicyThemeEventCreationDatetime]) as Date) as SignOffDate
							FROM Organisation.PolicyThemeEvents pte
								INNER JOIN Organisation.PolicyThemeEventTypes et
									ON pte.PolicyThemeEventTypeId = et.PolicyThemeEventTypeId
							WHERE et.PolicyThemeEventTypeBK = 'ReviewSignedOff'
							GROUP BY pte.PolicyThemeRegisterId) sod
			ON ptr.PolicyThemeRegisterId = sod.PolicyThemeRegisterId
	;

GO
CREATE TRIGGER [Access.ManyWho].[PolicyThemeRegisterVwTri]
ON [Access.ManyWho].[PolicyThemeRegisterVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY
	SET NOCOUNT ON

	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[PolicyThemeRegisterVwTri]';

	DECLARE @RegisterRst TABLE 
			( ACTION varchar(20)
			, PTPCategoryId smallint
			, PolicyThemeNameBK sysname
			, PolicyThemeOwnerRoleId smallint
			, PolicyThemeRegisterId int
			)
			;
	DECLARE @PolicyThemeProceduresRst TABLE
			(PolicyThemeProcedureId int
			, PolicyThemeRegisterId int 
			, PolicyThemeOwnerRoleId smallint
			)
			;

	MERGE INTO [Organisation].[PolicyThemeRegister] Tar
		USING ( SELECT ptpc.PTPCategoryId, i.PolicyThemeNameBK
					, i.ChangeStatus, i.ChangeReason
					, COALESCE( r.RoleId, i.PolicyThemeOwnerRoleId, -1) as PolicyThemeOwnerRoleId
					, i.PolicyThemeVersionNo, i.PolicyThemeSummary, i.DocumentationFolderLink
					, i.WorkflowVersionGUID, i.JoinGUID, i.SignOffDate
				FROM INSERTED i
					CROSS JOIN [Organisation].[PolicyThemeProcedureCategories] ptpc
					CROSS JOIN [Core].[Roles] r
				WHERE i.PTPCategoryBK = ptpc.PTPCategoryBK
				AND i.PolicyThemeOwnerRoleName = r.RoleName
				) Src
		ON Tar.[PolicyThemeNameBK] = Src.[PolicyThemeNameBK]
		WHEN NOT MATCHED THEN
			INSERT (PTPCategoryId, PolicyThemeNameBK, PolicyThemeExpiryDate, PolicyThemeDocumentStatus
					, ChangeStatus, ChangeReason, PolicyThemeSummary, PolicyThemeVersionNo, DocumentationFolderLink

					, WorkflowVersionGUID, JoinGUID)
				VALUES (Src.PTPCategoryId, Src.PolicyThemeNameBK, src.SignOffDate, 'Draft'
						, 'PendingReview', 'Development', Src.PolicyThemeSummary, Src.PolicyThemeVersionNo
						, DocumentationFolderLink, Src.WorkflowVersionGUID, Src.JoinGUID)
		WHEN MATCHED THEN
			UPDATE SET Tar.PolicyThemeSummary = ISNULL( Src.PolicyThemeSummary, Tar.PolicyThemeSummary)
					, Tar.ChangeStatus = ISNULL( Src.ChangeStatus, Tar.ChangeStatus)
					, Tar.ChangeReason = ISNULL( Src.ChangeReason, Tar.ChangeReason)
					, Tar.PolicyThemeVersionNo = ISNULL( Src.PolicyThemeVersionNo, Tar.PolicyThemeVersionNo)
					, Tar.DocumentationFolderLink = ISNULL( Src.DocumentationFolderLink, Tar.DocumentationFolderLink)
					, Tar.WorkflowVersionGUID = Src.WorkflowVersionGUID
					, Tar.JoinGUID = Src.JoinGUID
					, Tar.PolicyThemeLastModifiedDatetime = GetDate()
		OUTPUT $ACTION, INSERTED.PTPCategoryId, INSERTED.PolicyThemeNameBK, Src.PolicyThemeOwnerRoleId
					, INSERTED.PolicyThemeRegisterId
				INTO @RegisterRst(ACTION, PTPCategoryId, PolicyThemeNameBK, PolicyThemeOwnerRoleId, PolicyThemeRegisterId)
	;

	INSERT INTO [Organisation].[PolicyThemeProcedures]
		(PolicyThemeRegisterId, PTPCategoryId, PolicyThemeProcedureNameBK)
		OUTPUT INSERTED.PolicyThemeProcedureId, INSERTED.PolicyThemeRegisterId
			 INTO @PolicyThemeProceduresRst (PolicyThemeProcedureId, PolicyThemeRegisterId)
		SELECT PolicyThemeRegisterId, PTPCategoryId, PolicyThemeNameBK
		FROM @RegisterRst rr
		WHERE rr.ACTION = 'INSERT'
		;

	INSERT INTO [Organisation].[PolicyThemeProcedureRoleRelationship]
		([PolicyThemeProcedureId],[PolicyThemeRegisterId],[RoleId],[PolicyThemeProcedureOwner]
				, [PolicyThemeProcedureReviewer], [PolicyThemeProcedureSignatory])
		SELECT ptpr.[PolicyThemeProcedureId], ptpr.[PolicyThemeRegisterId], rr.PolicyThemeOwnerRoleId
				, 1 as [PolicyThemeProcedureOwner], 0 as [PolicyThemeProcedureReviewer]
				, 0 as [PolicyThemeProcedureSignatory]
		FROM @PolicyThemeProceduresRst ptpr
				INNER JOIN @RegisterRst rr
					ON ptpr.PolicyThemeRegisterId = rr.PolicyThemeRegisterId 
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
