CREATE PROCEDURE [Sales.BP].[usp_ApplyMatrixEDMExceptions] AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_ApplyMatrixEDMExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi: 25/05/2017 JIRA: Call Account and Contat Exception overrides to Datawarehouse and SF Stored procedures
--
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_ApplyMatrixEDMExceptions]';
BEGIN TRANSACTION

-- Run Account exception procedure
EXEC [Sales.BP].[usp_ApplyMatrixEDMAccountExceptions]
-- Run Contact exception procedure
EXEC [Sales.BP].[usp_ApplyMatrixEDMContactExceptions]
    
    
COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH    
    
    
