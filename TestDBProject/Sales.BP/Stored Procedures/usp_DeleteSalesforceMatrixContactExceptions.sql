CREATE PROCEDURE [Sales.BP].[usp_DeleteSalesforceMatrixContactExceptions]
AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_DeleteSalesforceMatrixContactExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- D.Bacchus: 15/05/2017 JIRA: DAP-867 Delete from [Sales.BP].ContactOverride where exception no longer exists
-- V.Khatri:  22/05/2018 JIRA: DAP-1760 Added MailingStreet, MailingCity, MailingState, MailingPostcode and MailingCountry
-- Vipul Khatri, 26/06/2018 DAP-1760 - DELETE FROM [Sales.BP].ContactOverride
-- Richard Dixon 27/07/18 - DAP-2234 - Delete raised and fixed exceptions.
-- Richard Dixon 24/08/18 - DAP-1753 - Include where datafield = 'ContactAccountId'.
-- Robert Walker 23/10/18 - DAP-2386 - Investigate why some Exception Overrides aren't persisting
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_DeleteSalesforceMatrixContactExceptions]';

BEGIN TRANSACTION

DELETE	CO
FROM	[Sales.BP].ContactOverride CO
WHERE	CO.OverrideStatus IN ('Raised','Fixed')

-- Delete from [Sales.BP].ContactOverride for ones which are no longer exceptions.
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'Salutation' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_Salutation <> ex.mx_Salutation
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'Salutation'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

--- Contact Owner
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'ContactOwnerId' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_ContactOwnerId <> ex.mx_ContactOwnerId
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'ContactOwnerId'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- First Name
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'FirstName' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_firstName  <> ex.mx_firstname
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'FirstName'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- Last Name
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'LastName' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_LastName  <> ex.mx_LastName
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'LastName'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- Phone
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'Phone' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_Phone <> ex.mx_Phone
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'Phone'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- Mobile
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'Mobile' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_Mobile <> ex.mx_Mobile
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'Mobile'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- EmailAddress
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'EmailAddress' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_emailAddress <> ex.mx_emailAddress
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'EmailAddress'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- ActiveStatus
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid, 
				'ActiveStatus' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.SF_ActiveStatus <> ex.MX_ActiveStatus
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'ActiveStatus'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL

-- ContactAccountId
DELETE	CO
FROM	[Sales.BP].ContactOverride CO
LEFT OUTER JOIN 
		(
		SELECT	ex.sf_Contactid,  
				'ContactAccountId' AS [DataField]
		FROM	[Sales.BP].[ExceptionsContactVw] ex
		WHERE	ex.sf_AccountSivId <> ex.mx_AccountSivId
		) EX
ON		EX.sf_contactID = CO.sf_SfContactId
AND		CO.DataField = EX.Datafield
WHERE	CO.DataField = 'ContactAccountId'
AND		EX.sf_contactID is NULL AND EX.Datafield IS NULL


-- Delete any salesforce/Manual overrides, which haven't been touched for 6 months 
DELETE FROM	[SALES.BP].ContactOverride
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

