
CREATE PROCEDURE [dbo].usp_SalesforceInsertNewPostcodeExceptions

AS
-------------------------------------------------------------------------------------- 
-- Name: [[dbo]].usp_SalesforceInsertNewPostcodeExceptions
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Vipul Khatri: 13/06/2018 JIRA: DAP-2045 set new postcodes to unknown user.
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_SalesforceInsertNewPostcodeExceptions]'
BEGIN TRANSACTION


INSERT dbo.T_REF_SALES_FORCE_POST_CODE_OWNER (POST_CODE,
FullEmployeeBK)

     SELECT DISTINCT mx.BillingPostcodeMapping,
                     'UNKNOWN' AS FullEmployeeBK
     FROM [Sales.BP].MxAccountVw mx
     LEFT OUTER JOIN dbo.T_REF_SALES_FORCE_POST_CODE_OWNER O
          ON mx.BillingPostcodeMapping = O.POST_CODE
     WHERE mx.BillingPostcodeMapping not in (select POST_CODE from T_REF_SALES_FORCE_POST_CODE_OWNER)
	 AND mx.BillingPostcode IS NOT  NULL

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH

