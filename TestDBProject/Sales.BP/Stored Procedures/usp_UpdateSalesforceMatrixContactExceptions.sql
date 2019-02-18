
CREATE PROCEDURE [Sales.BP].[usp_UpdateSalesforceMatrixContactExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_UpdateSalesforceMatrixContactExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon: 25/05/2017 JIRA: DAP-867 Update existing exceptions in ContactOverride table
-- V.Khatri: 08/05/2018 Jira: DAP-1760 Added extra fields to highlight exceptions
-- Vipul Khatri, 26/06/2018  DAP-1760 - Removed mailing address info.
-- Richard Dixon 24/08/18 - DAP-1753 - Include where datafield = 'ContactAccountId'.
-- Robert Walker 23/10/18 - DAP-2386 - Investigate why some Exception Overrides aren't persisting
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_UpdateSalesforceMatrixContactExceptions]';
BEGIN TRANSACTION

-- If SF or MX value different, set status to raised, override value to null, override choice to null

-- Salutation
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_Salutation,
		CO.mx_Value = EX.mx_Salutation,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'Salutation'
WHERE	ex.sf_Salutation  <> ex.mx_Salutation
AND		(CO.sf_Value <> EX.sf_Salutation OR CO.mx_Value <> EX.mx_Salutation)
AND		CO.OverrideStatus = 'Exported'

-- Contact Owner
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_ContactOwnerId,
		CO.mx_Value = EX.mx_ContactOwnerId,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'ContactOwnerId'
WHERE	ex.sf_ContactOwnerId  <> ex.mx_ContactOwnerId
AND		(CO.sf_Value <> EX.sf_ContactOwnerId OR CO.mx_Value <> EX.mx_ContactOwnerId)
AND		CO.OverrideStatus = 'Exported'

-- First Name
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_FirstName,
		CO.mx_Value = EX.mx_FirstName,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'FirstName'
WHERE	ex.sf_FirstName  <> ex.mx_FirstName
AND		(CO.sf_Value <> EX.sf_FirstName OR CO.mx_Value <> EX.mx_FirstName)
AND		CO.OverrideStatus = 'Exported'

-- Last Name
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_LastName,
		CO.mx_Value = EX.mx_LastName,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'LastName'
WHERE	ex.sf_LastName  <> ex.mx_LastName
AND		(CO.sf_Value <> EX.sf_LastName OR CO.mx_Value <> EX.mx_LastName)
AND		CO.OverrideStatus = 'Exported'

-- Phone
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_Phone,
		CO.mx_Value = EX.mx_Phone,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'Phone'
WHERE	ex.sf_Phone <> ex.mx_Phone
AND		(CO.sf_Value <> EX.sf_Phone OR CO.mx_Value <> EX.mx_Phone)
AND		CO.OverrideStatus = 'Exported'

-- Mobile
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_Mobile,
		CO.mx_Value = EX.mx_Mobile,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'Mobile'
WHERE	ex.sf_Mobile <> ex.mx_Mobile
AND		(CO.sf_Value <> EX.sf_Mobile OR CO.mx_Value <> EX.mx_Mobile)
AND		CO.OverrideStatus = 'Exported'

-- Email
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_emailAddress,
		CO.mx_Value = EX.mx_emailAddress,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'EmailAddress'
WHERE	ex.sf_emailAddress <> ex.mx_emailAddress
AND		(CO.sf_Value <> EX.sf_emailAddress OR CO.mx_Value <> EX.mx_emailAddress)
AND		CO.OverrideStatus = 'Exported'

-- ActiveStatus
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_ActiveStatus,
		CO.mx_Value = EX.mx_ActiveStatus,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'ActiveStatus'
WHERE	ex.sf_ActiveStatus  <> ex.mx_ActiveStatus
AND		(CO.sf_Value <> EX.sf_ActiveStatus OR CO.mx_Value <> EX.mx_ActiveStatus)
AND		CO.OverrideStatus = 'Exported'

-- ContactAccountId
UPDATE	CO
SET		CO.OverrideStatus = 'Raised',
		CO.OverrideValue = NULL,
		CO.OverrideChoice = NULL,
		CO.sf_Value = EX.sf_AccountSivId,
		CO.mx_Value = EX.mx_AccountSivId,
		CO.CADIS_SYSTEM_UPDATED = GETDATE()
FROM	[Sales.BP].ContactOverride CO
INNER	JOIN [Sales.BP].[ExceptionsContactVw] EX
ON		EX.sf_ContactID = CO.sf_SfContactId
AND		CO.DataField = 'ContactAccountId'
WHERE	ex.sf_AccountSivId <> ex.mx_AccountSivId
AND		(CO.sf_Value <> EX.sf_AccountSivId OR CO.mx_Value <> EX.mx_AccountSivId)
AND		CO.OverrideStatus = 'Exported'

COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH

