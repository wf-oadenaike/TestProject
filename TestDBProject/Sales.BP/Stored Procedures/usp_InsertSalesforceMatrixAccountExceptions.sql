

CREATE PROCEDURE [Sales.BP].[usp_InsertSalesforceMatrixAccountExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_InsertSalesforceMatrixAccountExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867 Insert Account Exceptions into AccountOverride table 
-- V.Khatri: 08/05/2018 Jira: DAP-1753 Added exceptions for Billingstreet, billingCity,billingCountry and IsActive
-- 
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Schema].[usp_ProcName]';
BEGIN TRANSACTION
-- Logic goes here, bear in mind the size of the transaction, there may be reason to have several transactions.


INSERT [Sales.BP].AccountOverride
(sf_SfAccountId, DataField, sf_FCAId, sf_OutletId, sf_value, mx_value, OverrideStatus)
(
		SELECT	ex.sf_SfAccountId, 
				'AccountName' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_AccountName AS [sf_Value],
				ex.mx_AccountName AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'AccountName'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_AccountName  <> ex.mx_AccountName
		AND		AO.sf_SfAccountId IS NULL

		  UNION  

		SELECT ex.sf_SfAccountId,   
			'AccountownerId' AS [DataField],  
			ex.sf_FCAId,   
			ex.sf_OutletId,   
			ex.sf_AccountownerId AS [sf_Value],  
			ex.mx_AccountownerId AS [mx_Value],  
			'Raised' AS [OverrideStatus]  
		FROM [Sales.BP].[ExceptionsAccountVw] ex  
		LEFT OUTER JOIN [Sales.BP].AccountOverride AO  
		ON  AO.DataField = 'AccountownerId'  
		AND  AO.sf_SfAccountId = ex.sf_SfAccountId  
		WHERE	ex.sf_AccountownerId  <> ex.mx_AccountownerId
		AND		AO.sf_SfAccountId IS NULL

		UNION

		SELECT	ex.sf_SfAccountId, 
				'BillingStreet' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_BillingStreet AS [sf_Value],
				ex.mx_BillingStreet AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'BillingStreet'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_BillingStreet  <> ex.mx_BillingStreet
		AND		AO.sf_SfAccountId IS NULL

		UNION

		SELECT	ex.sf_SfAccountId, 
				'BillingCity' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_BillingCity AS [sf_Value],
				ex.mx_BillingCity AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'BillingCity'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_BillingCity  <> ex.mx_BillingCity
		AND		AO.sf_SfAccountId IS NULL

		UNION

		SELECT	ex.sf_SfAccountId, 
				'BillingPostcode' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_BillingPostcode AS [sf_Value],
				ex.mx_BillingPostcode AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'BillingPostcode'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_BillingPostcode  <> ex.mx_BillingPostcode
		AND		AO.sf_SfAccountId IS NULL
		
		UNION

		SELECT	ex.sf_SfAccountId, 
				'BillingCountry' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_BillingCountry AS [sf_Value],
				ex.mx_BillingCountry AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'BillingCountry'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_BillingCountry  <> ex.mx_BillingCountry
		AND		AO.sf_SfAccountId IS NULL

		UNION

		SELECT	ex.sf_SfAccountId, 
				'Phone' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				ex.sf_Phone AS [sf_Value],
				ex.mx_Phone AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'Phone'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_Phone  <> ex.mx_Phone
		AND		AO.sf_SfAccountId IS NULL

		UNION

		SELECT	ex.sf_SfAccountId, 
				'ActiveStatus' AS [DataField],
				ex.sf_FCAId, 
				ex.sf_OutletId, 
				cast(ex.sf_ActiveStatus as varchar) AS [sf_Value],
				cast(ex.mx_ActiveStatus as varchar) AS [mx_Value],
				'Raised' AS [OverrideStatus]
		FROM	[Sales.BP].[ExceptionsAccountVw] ex
		LEFT	OUTER JOIN [Sales.BP].AccountOverride AO
		ON		AO.DataField = 'ActiveStatus'
		AND		AO.sf_SfAccountId = ex.sf_SfAccountId
		WHERE	ex.sf_ActiveStatus  <> ex.Mx_ActiveStatus
		AND		AO.sf_SfAccountId IS NULL
)

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH
