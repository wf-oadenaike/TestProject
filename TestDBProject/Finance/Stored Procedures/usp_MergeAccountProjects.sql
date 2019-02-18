 CREATE PROCEDURE [Finance].[usp_MergeAccountProjects]
		@ControlId BIGINT=-1
AS
-------------------------------------------------------------------------------------- 
-- Name:			Finance.usp_MergeAccountCategories
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Finance].[usp_MergeAccountProjects]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH Src AS
		(SELECT DISTINCT [PROJECT_ID] AS ProjectCode
			,[Project_Name] AS ProjectName
			,@ControlId AS ControlId
		FROM [Staging].[GL_LLP_Discretionary]
		WHERE Project_Id IS NOT NULL AND [PROJECT_ID] <> '0'
		)
	MERGE INTO Finance.AccountProjects Tar
	USING Src
	ON ( Tar.ProjectCode = Src.ProjectCode)
	WHEN NOT MATCHED
		THEN INSERT (ProjectCode, ProjectName, ControlId)
			 VALUES (Src.ProjectCode, Src.ProjectName, Src.ControlId)
	WHEN MATCHED AND ( Tar.ProjectName <> Src.ProjectName)
		THEN UPDATE SET ProjectName = Src.ProjectName
						, ControlId = Src.ControlId
	OUTPUT $action, inserted.*
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
