CREATE PROCEDURE [Core].[usp_MergeRolePersonRelationship]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Core].[usp_MergeRolePersonRelationship]
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

BEGIN TRY

	SET NOCOUNT ON

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Core].[usp_MergeRolePersonRelationship]';
	
	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	MERGE INTO [Core].[RolePersonRelationship] Tar
		USING ( SELECT r.RoleId, p.PersonId, js.[Current] as ActiveFlag, js.[Effective from] as ActiveFromDatetime, CAST( ISNULL( js.[Effective to], '2020-12-31') as Datetime) as ActiveToDatetime
				FROM [Staging.Salesforce].[JobRolesSrc] js
					INNER JOIN [Core].[Roles] r
						ON  js.[Role] = r.RoleBK
					INNER JOIN [Staging.Salesforce].[EmployeesSrc] e
						ON js.[Employee: ID] = e.[Employee: ID]
					LEFT OUTER JOIN [Core].[Persons] p
						ON  e.UserId = p.FullEmployeeBK
				--WHERE js.[Effective to] IS NULL
				--AND r.ActiveFlag = 1
				--AND p.ActiveFlag = 1
				
				) Src
	ON --Tar.RoleId = Src.RoleId AND 
	Tar.PersonId = Src.PersonId
	AND Tar.ActiveFromDatetime = Src.ActiveFromDatetime
	WHEN NOT MATCHED THEN
		INSERT (RoleId, PersonId, ActiveFlag, ActiveFromDatetime, ActiveToDatetime, ControlId)
			VALUES (Src.RoleId, Src.PersonId, Src.ActiveFlag, Src.ActiveFromDatetime, Src.ActiveToDatetime, @ControlId)
	WHEN MATCHED AND (Tar.ActiveFlag <> Src.ActiveFlag 
					OR Tar.ActiveToDatetime <> Src.ActiveToDatetime
					OR Tar.RoleId <> Src.RoleId
					) 
	THEN
		UPDATE SET Tar.ActiveFlag = Src.ActiveFlag 
				, Tar.RoleId = Src.RoleId
				, Tar.ActiveToDatetime = Src.ActiveToDatetime
				, ControlID = @ControlId
	;


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
