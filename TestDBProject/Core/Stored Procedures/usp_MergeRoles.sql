CREATE PROCEDURE [Core].[usp_MergeRoles]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Core].[usp_MergeRoles]
-- 
-- Note:			
-- 
-- Author:			I Pearson
-- Date:			06/05/2015
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Core].[usp_MergeRoles]';

	DECLARE @RstTbl TABLE 
			( RstAct varchar(12), RoleId smallint
					, SrcRoleBK varchar(18) null, SrcRoleName sysname null
					, IRoleName sysname null, DRoleName sysname null
					, IActiveFlag bit null, DActiveFlag bit null)
					;

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;
	
	BEGIN TRANSACTION

		MERGE INTO Core.Roles Tar
		USING (	
				SELECT Distinct cr.[Company Job Role: ID] as RoleBK, cr.[Company Job Role: Job role] as RoleName, ss.SourceSystemId, 1 as ActiveFlag
				FROM [Staging.Salesforce].CompanyJobRolesSrc cr
					CROSS JOIN Audit.SourceSystems ss
				WHERE ss.SourceSystemCode = 'SFDC'
				--ORDER BY r.[Company Job Role: ID]
				) Src
		ON Tar.RoleBK = Src.RoleBK
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (RoleBK, RoleName, SourceSystemId, ActiveFlag, ControlId, RoleCreationDatetime, RoleLastModifiedDatetime)
				VALUES ( Src.RoleBK, Src.RoleName, Src.SourceSystemId, Src.ActiveFlag, @ControlId, GetDate(), GetDate())
		WHEN MATCHED AND (Tar.RoleName <> src.RoleName OR Tar.SourceSystemId <> Src.SourceSystemId)
			THEN 
			UPDATE SET Tar.RoleName = src.RoleName
					, Tar.RoleNameSCD1 = CASE WHEN Tar.RoleName <> src.RoleName THEN Tar.RoleName ELSE Tar.RoleNameSCD1 END
					, Tar.SourceSystemId = Src.SourceSystemId
					, Tar.ActiveFlag = Src.ActiveFlag
					, Tar.RoleLastModifiedDatetime = GETDATE()
		WHEN NOT MATCHED BY SOURCE
			THEN UPDATE SET Tar.ActiveFlag = 0
						, Tar.RoleLastModifiedDatetime = GETDATE()
		OUTPUT $ACTION, INSERTED.RoleId, Src.RoleBK, Src.RoleName, INSERTED.RoleName, DELETED.RoleName, INSERTED.ActiveFlag, DELETED.ActiveFlag
			INTO @RstTbl( RstAct, RoleId, SrcRoleBK, SrcRoleName, IRoleName, DRoleName, IActiveFlag, DActiveFlag) 
			;
		
		SET @InsertRowCount = @@ROWCOUNT;

		UPDATE rd
				SET ActiveFlag = 0
				, rd.ActiveToDatetime = GETDATE()
				, rd.ControlId = @ControlId
				--OUTPUT INSERTED.RoleId, DELETED.RoleId, INSERTED.DepartmentId, DELETED.DepartmentId, INSERTED.ActiveFlag, DELETED.ActiveFlag
				--		, INSERTED.ActiveFromDatetime, DELETED.ActiveFromDatetime, INSERTED.ActiveToDatetime, DELETED.ActiveToDatetime
				FROM @RstTbl rt
					INNER JOIN Core.RoleDepartmentRelationship rd
						ON rt.RoleId = rd.RoleId
				WHERE rt.iActiveFlag = 0
				;

		SET @UpdateRowCount = @@ROWCOUNT;

		UPDATE rp
				SET rp.ActiveFlag = 0
				, rp.ActiveToDatetime = GETDATE()
				, rp.ControlId = @ControlId
				--OUTPUT INSERTED.RoleId, DELETED.RoleId, INSERTED.PersonId, DELETED.PersonId, INSERTED.ActiveFlag, DELETED.ActiveFlag
				--		, INSERTED.ActiveFromDatetime, DELETED.ActiveFromDatetime, INSERTED.ActiveToDatetime, DELETED.ActiveToDatetime
				FROM @RstTbl rt
					INNER JOIN Core.RolePersonRelationship rp
						ON rt.RoleId = rp.RoleId
				WHERE rt.iActiveFlag = 0
				;

	SET @UpdateRowCount = @UpdateRowCount + @@ROWCOUNT;

	COMMIT;

	SELECT @ProcessRowCount AS ProcessRowCount
		, @InsertRowCount AS InsertRowCount
		, @UpdateRowCount AS UpdateRowCount
		, @DeleteRowCount AS DeleteRowCount
		;

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		IF @@TRANCOUNT > 0 ROLLBACK;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH


--	EXEC [Core].[usp_MergeRoles] @ControlId =-1
