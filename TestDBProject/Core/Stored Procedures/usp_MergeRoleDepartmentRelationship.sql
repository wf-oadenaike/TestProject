CREATE PROCEDURE [Core].[usp_MergeRoleDepartmentRelationship]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Core.[usp_MergeRoleDepartmentRelationship]
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Core].[usp_MergeRoleDepartmentRelationship]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	--BEGIN TRANSACTION

		MERGE INTO [Core].[RoleDepartmentRelationship] Tar
		USING ( SELECT DISTINCT r.RoleId, d.DepartmentId
				FROM [Staging.Salesforce].[JobRolesSrc] jr
					INNER JOIN Core.Roles r
						ON jr.[Role] = r.RoleBK
					LEFT OUTER JOIN Core.Departments d
						ON jr.[Department code] = d.DepartmentNumber
				WHERE r.ActiveFlag = 1
				AND d.ActiveFlag = 1
				AND jr.[Current] = 'true'
				) Src
		ON Tar.RoleId = Src.RoleId
		AND Tar.DepartmentId = Src.DepartmentId
		WHEN NOT MATCHED BY TARGET
			THEN INSERT ( RoleId, DepartmentId, ActiveFlag, ActiveFromDatetime, ActiveToDatetime, ControlId) 
					VALUES ( Src.RoleId, Src.DepartmentId, 1, GetDate(), '2020-12-31', @ControlId)
		WHEN NOT MATCHED BY SOURCE AND Tar.ActiveFlag = 1 
			THEN UPDATE SET Tar.ActiveFlag = 0
							, Tar.ActiveToDatetime = GetDate()
							, Tar.ControlId = @ControlId
			;

	--COMMIT;

	SET @InsertRowCount = @@ROWCOUNT;

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

--	EXEC [Core].[usp_MergeRoleDepartmentRelationship] @ControlId =-1
