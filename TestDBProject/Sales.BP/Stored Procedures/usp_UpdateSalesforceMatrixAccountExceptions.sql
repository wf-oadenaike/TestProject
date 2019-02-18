
CREATE PROCEDURE [Sales.BP].[usp_UpdateSalesforceMatrixAccountExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_UpdateSalesforceMatrixAccountExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867 Update existing exceptions in AccountOverride table
-- V.Khatri: 08/05/2018 Jira: DAP-1753 Added exceptions for Billingstreet, billingCity,billingCountry and IsActive
-- Robert Walker 23/10/18 - DAP-2386 - Investigate why some Exception Overrides aren't persisting
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_UpdateSalesforceMatrixAccountExceptions]';
BEGIN TRANSACTION


-- If SF or MX value different, set status to raised, override value to null, override choice to null
-- Account Name
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_AccountName,
		AO.mx_Value = EX.mx_AccountName,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'AccountName'
WHERE	ex.sf_AccountName  <> ex.mx_AccountName
AND		(AO.sf_Value <> EX.sf_AccountName OR AO.mx_Value <> EX.mx_AccountName)
AND		AO.OverrideStatus = 'Exported'

-- Account Owner
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_accountownerId,
		AO.mx_Value = EX.mx_accountownerId,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'AccountOwnerId'
WHERE	ex.sf_accountownerId  <> ex.mx_accountownerId
AND		(AO.sf_Value <> EX.sf_accountownerId OR AO.mx_Value <> EX.mx_accountownerId)
AND		AO.OverrideStatus = 'Exported'

-- BillingStreet
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_BillingStreet,
		AO.mx_Value = EX.mx_BillingStreet,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'BillingStreet'
WHERE	ex.sf_BillingStreet  <> ex.mx_BillingStreet
AND		(AO.sf_Value <> EX.sf_BillingStreet OR AO.mx_Value <> EX.mx_BillingStreet)
AND		AO.OverrideStatus = 'Exported'

-- BillingCity
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_BillingCity,
		AO.mx_Value = EX.mx_BillingCity,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'BillingCity'
WHERE	ex.sf_BillingCity  <> ex.mx_BillingCity
AND		(AO.sf_Value <> EX.sf_BillingCity OR AO.mx_Value <> EX.mx_BillingCity)
AND		AO.OverrideStatus = 'Exported'

-- Billing PostCode
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_BillingPostCode,
		AO.mx_Value = EX.mx_BillingPostCode,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'BillingPostCode'
WHERE	ex.sf_BillingPostCode  <> ex.mx_BillingPostCode
AND		(AO.sf_Value <> EX.sf_BillingPostCode OR AO.mx_Value <> EX.mx_BillingPostCode)
AND		AO.OverrideStatus = 'Exported'


-- BillingCountry
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_BillingCountry,
		AO.mx_Value = EX.mx_BillingCountry,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'BillingCountry'
WHERE	ex.sf_BillingCountry  <> ex.mx_BillingCountry
AND		(AO.sf_Value <> EX.sf_BillingCountry OR AO.mx_Value <> EX.mx_BillingCountry)
AND		AO.OverrideStatus = 'Exported'

-- Phone
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_Phone,
		AO.mx_Value = EX.mx_Phone,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'Phone'
WHERE	ex.sf_Phone  <> ex.mx_Phone
AND		(AO.sf_Value <> EX.sf_Phone OR AO.mx_Value <> EX.mx_Phone)
AND		AO.OverrideStatus = 'Exported'

-- Activestatus
UPDATE	AO
SET		AO.OverrideStatus = 'Raised',
		AO.OverrideValue = NULL,
		AO.OverrideChoice = NULL,
		AO.sf_Value = EX.sf_Activestatus,
		AO.mx_Value = EX.mx_Activestatus,
		AO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].AccountOverride AO
INNER	JOIN [Sales.BP].[ExceptionsAccountVw] ex
ON		EX.sf_sfaccountID = AO.sf_SfAccountId
AND		AO.DataField = 'Activestatus'
WHERE	ex.sf_Activestatus  <> ex.mx_Activestatus
AND		(AO.sf_Value <> EX.sf_Activestatus OR AO.mx_Value <> EX.mx_Activestatus)
AND		AO.OverrideStatus = 'Exported'


COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH


