
CREATE PROCEDURE [Sales.BP].[usp_GenerateSalesforceMatrixAccountExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_GenerateSalesforceMatrixAccountExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867  Generate exceptions from SalesForce and Matrix account and contact data
--
-- R.Walker: 01/08/2018 JIRA: DAP-2241  Separate Contact and Account processing
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_GenerateSalesforceMatrixAccountExceptions]';
BEGIN TRANSACTION

-- Accounts
-- Delete from [Sales.BP].AccountOverride where exception no longer exists
exec [Sales.BP].usp_DeleteSalesforceMatrixAccountExceptions

-- Insert New exceptions into [Sales.BP].AccountOverride - with status of 'Raised'
exec [Sales.BP].usp_InsertSalesforceMatrixAccountExceptions

-- Update Existing entries in [Sales.BP].AccountOverride 
exec [Sales.BP].usp_UpdateSalesforceMatrixAccountExceptions

-- New Accounts
-- Delete exported records
exec [Sales.BP].usp_DeleteSalesforceMatrixNewAccounts

--import new records
exec [Sales.BP].usp_InsertSalesforceMatrixNewAccounts

-- Postcode overrides
-- Delete old records
exec [dbo].usp_SalesforceDeletePostcodeExceptions

--import new records
exec [dbo].usp_SalesforceInsertPostcodeExceptions

--import any new postcodes with unknown user. 
exec usp_SalesforceInsertNewPostcodeExceptions


COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH

