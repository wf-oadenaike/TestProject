
CREATE PROCEDURE [Sales.BP].[usp_GenerateSalesforceMatrixContactExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_GenerateSalesforceMatrixContactExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867  Generate exceptions from SalesForce and Matrix account and contact data
-- R.Walker: 01/08/2018 JIRA: DAP-2241  Separate Contact and Account processing-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_GenerateSalesforceMatrixContactExceptions]';
BEGIN TRANSACTION

-- Contacts
-- Delete from [Sales.BP].ContactOverride where exception no longer exists
exec [Sales.BP].usp_DeleteSalesforceMatrixContactExceptions

-- Insert New exceptions into [Sales.BP].AccountOverride - with status of 'Raised'
exec [Sales.BP].usp_InsertSalesforceMatrixContactExceptions

-- Update Existing entries in [Sales.BP].AccountOverride 
exec [Sales.BP].usp_UpdateSalesforceMatrixContactExceptions


COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH

