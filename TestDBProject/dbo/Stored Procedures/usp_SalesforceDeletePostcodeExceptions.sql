
CREATE PROCEDURE [dbo].[usp_SalesforceDeletePostcodeExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[usp_SalesforceDeletePostcodeExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- V.Khatri: 30/05/2018 JIRA: DAP-2068 	Delete exported records from SalesforcePostcodeOverride table
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_SalesforceDeletePostcodeExceptions]';
BEGIN TRANSACTION


DELETE	
FROM	T_SALESFORCE_POSTCODE_OVERRIDE
WHERE	[OverrideStatus] = 'Raised'

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH
