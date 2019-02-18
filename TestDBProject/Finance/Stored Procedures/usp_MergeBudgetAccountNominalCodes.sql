CREATE PROCEDURE [Finance].[usp_MergeBudgetAccountNominalCodes]
	@ControlId BIGINT=-1
AS

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Finance].[usp_MergeBudgetAccountNominalCode]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH accountCategories AS (
	SELECT AccountCategoryId, AccountCategory
	FROM [Finance].[AccountCategories]
) ,
Src AS
		(SELECT DISTINCT NominalCode, MAX(AccountName) AS AccountName
			FROM
			(
			SELECT Distinct [NominalCode] AS NominalCode, Heading3 AS AccountName		
			FROM [Staging].[BudgetDept-Data] data 
			WHERE NULLIF(LTRIM(RTRIM(NominalCode)),'') IS NOT NULL
			AND IsExpense = 1
						UNION
			SELECT Distinct [NominalCode] AS NominalCode, Heading2
			FROM [Staging].[BudgetDept-Data] data 
			WHERE NULLIF(LTRIM(RTRIM(NominalCode)),'') IS NOT NULL
			AND IsExpense = 0
			) Data
			GROUP BY NominalCode

		)

	MERGE INTO Finance.AccountNominalCodes Tar
	USING Src
	ON ( Tar.[NominalCode] = Src.[NominalCode])
	WHEN NOT MATCHED
		THEN INSERT ([NominalCode], [AccountName])
			 VALUES (Src.[NominalCode], Src.AccountName)
	
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
