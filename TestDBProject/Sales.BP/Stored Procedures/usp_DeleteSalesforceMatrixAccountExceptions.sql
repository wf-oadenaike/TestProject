CREATE PROCEDURE [Sales.BP].[usp_DeleteSalesforceMatrixAccountExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].usp_DeleteSalesforceMatrixAccountExceptions
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867
-- Delete from [Sales.BP].AccountOverride where exception no longer exists
-- V.Khatri: 08/05/2018 Jira: DAP-1753
-- Added exceptions for Billingstreet, billingCity,billingCountry and IsActive
-- V.Khatri: 27/06/2018 Jira: DAP-1760
-- Richard Dixon 27/07/18 - DAP-2234 - Delete raised and fixed exceptions.
-------------------------------------------------------------------------------------- 

BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_DeleteSalesforceMatrixAccountExceptions]';
BEGIN TRANSACTION

DELETE	CO
FROM	[Sales.BP].AccountOverride CO
WHERE	CO.OverrideStatus IN ('Raised','Fixed')


-- Delete from [Sales.BP].[AccountOverride] for ones which are no longer exceptions.
DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'AccountName' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_AccountName <> ex.mx_AccountName
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'AccountName'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL


DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'AccountownerId' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_AccountownerId <> ex.mx_AccountownerId
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'AccountownerId'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL


DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'BillingStreet' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_BillingStreet <> ex.mx_BillingStreet
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'BillingStreet'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL


DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'BillingCity' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_BillingCity <> ex.mx_BillingCity
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'BillingCity'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL


DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'BillingPostcode' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_BillingPostcode <> ex.mx_BillingPostcode
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'BillingPostcode'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL

DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'BillingCountry' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_BillingCountry <> ex.mx_BillingCountry
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'BillingCountry'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL


DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'Phone' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_Phone <> ex.mx_Phone
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'Phone'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL

DELETE	CO
FROM	[Sales.BP].AccountOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_SfAccountId, 
				'ActiveStatus' AS [DataField]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		WHERE	ex.sf_ActiveStatus <> ex.mx_ActiveStatus
		) EX
ON		EX.sf_SfAccountId = CO.sf_SfAccountId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'ActiveStatus'
AND		EX.sf_sfaccountID is NULL AND EX.Datafield IS NULL

-- Delete any salesforce/Manual overrides, which haven't been touched for 6 months 
DELETE FROM	[SALES.BP].ACCOUNTOVERRIDE
WHERE OVERRIDESTATUS = 'EXPORTED'
AND OVERRIDECHOICE != 'MATRIX' -- NOT USING MATRIX VALUE
AND CADIS_SYSTEM_INSERTED < DATEADD(MONTH,-6,GETDATE())


COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH


