CREATE PROCEDURE [Finance].[usp_MergeActualAccountNominalCodes]
	@ControlId BIGINT=-1
AS

Begin Try

	Set NoCount on

	Declare @ProcessRowCount Bigint = 0
		, @InsertRowCount bigint = 0
		, @UpdateRowCount bigint = 0	
		, @DeleteRowCount bigint = 0
		;
	Declare	@strProcedureName		VARCHAR(100)	= '[Finance].[usp_MergeActualAccountNominalCode]';

	IF (@ControlId = -1) BEGIN
		SELECT @ControlId = CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
	END;

	WITH accountCategories AS (
	SELECT AccountCategoryId, AccountCategory
	FROM [Finance].[AccountCategories]
) 
	MERGE INTO Finance.AccountNominalCodes Tar
	USING 
	(
	SELECT [Nominal_Code] AS NominalCode, MAX([F20]) AS Account, max(ac.AccountCategoryId) as AccountCategoryId
					
			FROM [Staging].[GL_LLP] data 
			LEFT JOIN
			Finance.[AccountCategories] ac ON ac.AccountCategory = data.[Account Category]
			--WHERE [Nominal_Code] >= 4000
			GROUP BY [Nominal_Code]
	) AS Src1
	ON ( Tar.[NominalCode] = Src1.[NominalCode])
	WHEN NOT MATCHED
		THEN INSERT ([NominalCode], [AccountName], AccountCategoryId)
			 VALUES (Src1.NominalCode, Src1.Account, Src1.AccountCategoryId)
	--WHEN MATCHED AND ( ISNULL(Tar.[AccountName],'ABCDE') <> Src1.Account
	--			OR ISNULL(Tar.AccountCategoryId,-999) <> Src1.AccountCategoryId)
	--	THEN UPDATE SET [AccountName] = Src1.Account
	--					, AccountCategoryId = Src1.AccountCategoryId
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
