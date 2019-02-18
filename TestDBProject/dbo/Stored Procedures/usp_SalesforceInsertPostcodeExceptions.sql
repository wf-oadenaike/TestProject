
CREATE PROCEDURE [dbo].usp_SalesforceInsertPostcodeExceptions

AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].usp_SalesforceInsertPostcodeExceptions
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- V.Khatri: 30/05/2018 JIRA: DAP-2068 Insert records into T_SALESFORCE_POSTCODE_OVERRIDE
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[dbo].[usp_SalesforceInsertPostcodeExceptions]'
BEGIN TRANSACTION

INSERT [dbo].[T_SALESFORCE_POSTCODE_OVERRIDE]
		(SfAccountId,
		AccountName,
		WF_PRIMARY_BUSINESS,
		BillingStreet,
		BillingCity,
		BillingPostcode,
		AccountOwnerId,
		OriginalAccountOwnerId,
		OverrideStatus)

select	 S.SfAccountId,
		 S.AccountName,
		 s.WF_PRIMARY_BUSINESS,
		 S.BillingStreet,
		 S.BillingCity,
		 S.BillingPostcode,
		 s.AccountOwnerId,
		 s.AccountOwnerId,
		 'Raised'
from [Sales.BP].[SfAccountVw] S
where SfAccountId not in (select SfAccountId from [T_SALESFORCE_POSTCODE_OVERRIDE])

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH