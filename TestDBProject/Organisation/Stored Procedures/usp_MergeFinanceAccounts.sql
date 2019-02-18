CREATE PROCEDURE [Organisation].[usp_MergeFinanceAccounts]

AS
-------------------------------------------------------------------------------------- 
-- Name:			Finance.usp_MergeFinanceAccounts
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			01/02/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
--
-- 
-------------------------------------------------------------------------------------- 

BEGIN TRY

	Set NoCount on

	DECLARE	@strProcedureName		VARCHAR(100)	= '[Organisation].[usp_MergeFinanceAccounts]';

	MERGE INTO [Organisation].[FinanceAccounts] Tar
	USING ( SELECT DISTINCT LTRIM(RTRIM(llp.[F20])) as [AccountName], llp.[NominalCode] as [NominalCode],  ac.[AccountCategory] as [CategoryName]
			FROM [Staging].[GL_LLP] llp
			LEFT OUTER JOIN [Finance].[AccountCategories] ac 
			ON ac.AccountCategory = llp.[Account Category]
			) as Src
	ON ( Tar.AccountName = Src.AccountName
	AND Tar.NominalCode = Src.NominalCode
	)
	WHEN NOT MATCHED BY TARGET
	THEN INSERT ([NominalCode], [AccountName], [CategoryName])
		 VALUES (Src.[NominalCode], Src.[AccountName], Src.[CategoryName])
	WHEN MATCHED AND (Tar.CategoryName IS NULL AND Src.CategoryName IS NOT NULL) 
	             OR (Tar.CategoryName IS NOT NULL AND Src.CategoryName IS NULL)
	             OR Tar.CategoryName != Src.CategoryName THEN
	     UPDATE SET CategoryName = Src.CategoryName
	OUTPUT $action, inserted.*
	;
	  
END TRY
BEGIN CATCH
		DECLARE   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		SELECT	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		RETURN @ErrorNumber;
END CATCH
