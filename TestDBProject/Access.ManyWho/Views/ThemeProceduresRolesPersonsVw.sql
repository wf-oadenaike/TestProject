

CREATE VIEW [Access.ManyWho].[ThemeProceduresRolesPersonsVw] as
	SELECT DISTINCT cr.PTPCategoryBK AS RegisterCategory, ptr.PolicyThemeRegisterId, ptr.PolicyThemeNameBK, cp.PTPCategoryBK as ThemeProcedureCategory
			, ptp.PolicyThemeProcedureId, ptp.PolicyThemeProcedureNameBK, ptp.ActiveFlag, rr.ActiveFlag as RoleRelationshipActiveFlag
			, rr.RoleId, r.RoleName, rr.PolicyThemeProcedureOwner, rr.PolicyThemeProcedureReviewer, rr.PolicyThemeProcedureSignatory
			, p.PersonId, p.PersonsName, p.EmployeeBK as PersonSalesforceUserId
	FROM Organisation.PolicyThemeProcedureCategories cr
			INNER JOIN Organisation.PolicyThemeRegister ptr
				ON cr.PTPCategoryId = ptr.PTPCategoryId
			INNER JOIN [Organisation].[PolicyThemeProcedures] ptp
				ON ptr.PolicyThemeRegisterId = ptp.PolicyThemeRegisterId
				INNER JOIN Organisation.PolicyThemeProcedureCategories cp
					ON ptp.PTPCategoryId = cp.PTPCategoryId
			INNER JOIN Organisation.PolicyThemeProcedureRoleRelationship rr
				ON ptp.PolicyThemeRegisterId = rr.PolicyThemeRegisterId
				INNER JOIN Core.Roles r
					ON rr.RoleId = r.RoleId
			LEFT OUTER JOIN Core.RolePersonRelationship rp
				ON rr.RoleId = rp.RoleId
				LEFT OUTER JOIN Core.Persons p
					ON rp.PersonId = p.PersonId
	WHERE -- cr.PTPCategoryBK = 'Theme'
	--AND cp.PTPCategoryBK = 'Procedure'
	rp.ActiveFlag = 1
	AND p.ActiveFlag = 1

	;


GO

CREATE TRIGGER [Access.ManyWho].[ThemeProceduresRolesPersonsVwTri]
ON [Access.ManyWho].[ThemeProceduresRolesPersonsVw]
INSTEAD OF INSERT, UPDATE
AS
BEGIN TRY

	SET NOCOUNT ON
	
	DECLARE	@strTriggerName		VARCHAR(100)	= '[Access.ManyWho].[ThemeProceduresRolesPersonsVwTri]';

	BEGIN TRANSACTION

	-- Maintain the Procedure information
	MERGE INTO [Organisation].[PolicyThemeProcedures] Tar
	USING ( SELECT ptr.[PolicyThemeRegisterId]
				  ,c.PTPCategoryId
				  ,i.[PolicyThemeProcedureNameBK]
				  ,i.[ActiveFlag]
			  FROM INSERTED i
				INNER JOIN [Organisation].[PolicyThemeRegister] ptr
					ON i.PolicyThemeNameBK = ptr.PolicyThemeNameBK
				INNER JOIN [Organisation].[PolicyThemeProcedureCategories] c
					ON i.ThemeProcedureCategory = c.PTPCategoryBK
				) Src
	ON Tar.[PolicyThemeProcedureNameBK] = Src.[PolicyThemeProcedureNameBK]
	AND Tar.PTPCategoryId = Src.PTPCategoryId
	WHEN NOT MATCHED
		THEN INSERT (PolicyThemeRegisterId, PTPCategoryId, PolicyThemeProcedureNameBK
						, ActiveFlag, ActiveFromDatetime, ActiveToDatetime)
				VALUES (Src.PolicyThemeRegisterId, Src.PTPCategoryId, Src.PolicyThemeProcedureNameBK
						, 1, GetDate(), '2020-12-31')
	WHEN MATCHED
		THEN UPDATE SET Tar.ActiveFlag = Src.ActiveFlag
						, Tar.ActiveToDatetime = CASE WHEN Tar.ActiveFlag <> Src.ActiveFlag AND Src.ActiveFlag = 0 THEN GetDate() 
												ELSE Tar.ActiveToDatetime END
	;

	-- Maintain the Role relationship mapping for procedures
	MERGE INTO [Organisation].[PolicyThemeProcedureRoleRelationship] Tar
	USING ( SELECT ptp.PolicyThemeProcedureId
					, ptr.PolicyThemeRegisterId	
					, r.RoleId
					, i.[PolicyThemeProcedureOwner]
					, i.[PolicyThemeProcedureReviewer]
					, i.[PolicyThemeProcedureSignatory]
					, ptp.ActiveFlag
					, i.RoleRelationshipActiveFlag
			FROM INSERTED i
				INNER JOIN [Organisation].[PolicyThemeProcedures] ptp
					ON i.PolicyThemeProcedureNameBK = ptp.PolicyThemeProcedureNameBK
				INNER JOIN [Organisation].[PolicyThemeRegister] ptr
					ON i.PolicyThemeNameBK = ptr.PolicyThemeNameBK
				INNER JOIN [Core].[Roles] r
					ON i.RoleName = r.RoleName
			) Src
	ON Tar.PolicyThemeProcedureId = Src.PolicyThemeProcedureId
	AND Tar.PolicyThemeRegisterId = Src.PolicyThemeRegisterId
	AND Tar.RoleId = Src.RoleId
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (PolicyThemeProcedureId, PolicyThemeRegisterId, RoleId
					, PolicyThemeProcedureOwner, PolicyThemeProcedureReviewer, PolicyThemeProcedureSignatory
					, ActiveFlag, ActiveFromDatetime, ActiveToDatetime, PolicyThemeProcedureLastModifiedDatetime)
				VALUES (Src.PolicyThemeProcedureId, Src.PolicyThemeRegisterId, Src.RoleId
					, Src.PolicyThemeProcedureOwner, Src.PolicyThemeProcedureReviewer, Src.PolicyThemeProcedureSignatory
					, 1, GetDate(), '2020-12-31', GetDate())
	WHEN MATCHED AND Tar.[PolicyThemeProcedureOwner] <> Src.[PolicyThemeProcedureOwner]
					OR Tar.[PolicyThemeProcedureReviewer] <> Src.[PolicyThemeProcedureReviewer]
					Or Tar.[PolicyThemeProcedureSignatory] <> Src.[PolicyThemeProcedureSignatory]
					OR Tar.ActiveFlag <> CASE WHEN Src.ActiveFlag = 0 or Src.RoleRelationshipActiveFlag = 0 THEN 0 ELSE Tar.ActiveFlag END
		THEN UPDATE SET Tar.[PolicyThemeProcedureOwner] = Src.[PolicyThemeProcedureOwner]
					, Tar.[PolicyThemeProcedureReviewer] = Src.[PolicyThemeProcedureReviewer]
					, Tar.[PolicyThemeProcedureSignatory]= Src.[PolicyThemeProcedureSignatory]
					, Tar.ActiveFlag = CASE WHEN Src.ActiveFlag = 0 or Src.RoleRelationshipActiveFlag = 0 THEN 0 ELSE Tar.ActiveFlag END
					, Tar.ActiveToDatetime = CASE WHEN Tar.ActiveFlag <> Src.ActiveFlag AND Src.ActiveFlag = 0 THEN GetDate() 
												ELSE Tar.ActiveToDatetime END
					, Tar.PolicyThemeProcedureLastModifiedDatetime = GetDate()
		;

	COMMIT;

END TRY
BEGIN CATCH

		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		IF @@TRANCOUNT > 0 ROLLBACK;

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
