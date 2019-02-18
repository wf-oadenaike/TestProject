CREATE PROCEDURE [Sales.BP].[usp_DeleteSalesforceMatrixAccountMovements]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_DeleteSalesforceMatrixAccountMovements]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867	Delete exported records from FCAccountMovementOverride table
-- R.Dixon: 22/11/2017 JIRA: DAP-1446	Amended to delete all records from FCAccountMovementOverride table
--										ahead of refreshing with next month's data
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[FCAccountMovementOverride]';
BEGIN TRANSACTION


DELETE	
FROM	[Sales.BP].FCAccountMovementOverride
--WHERE	[OverrideStatus] = 'Exported'

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH

