CREATE PROCEDURE [Finance].[usp_MergeBudgetAccountCategories]
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
	Declare	@strProcedureName		VARCHAR(100)	= '[Finance].[usp_MergeBudgetAccountCategories]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH Src AS
		(
			SELECT Heading2 AS AccountCategory
			FROM [Staging].[BudgetDept-Data]
			WHERE IsExpense = 1 AND NULLIF(LTRIM(RTRIM(Heading3)),'') IS NOT NULL
			AND Heading2 IS NOT NULL
		)
	MERGE INTO Finance.AccountCategories Tar
	USING Src
	ON ( Tar.[AccountCategory] = Src.[AccountCategory])
	WHEN NOT MATCHED
		THEN INSERT (AccountCategory, AccountCategoryDescription, PnLBS, ControlId)
			 VALUES (Src.AccountCategory, '' , 0, @ControlId)
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

--BEGIN
	
--	DECLARE @CID BIGINT;
--	SELECT @CID = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
--	EXEC [Finance].[usp_MergeAccountCategories] @ControlId =20000401000000

--END
