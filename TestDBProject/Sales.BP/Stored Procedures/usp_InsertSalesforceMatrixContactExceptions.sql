

CREATE PROCEDURE [Sales.BP].[usp_InsertSalesforceMatrixContactExceptions]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Sales.BP].[usp_InsertSalesforceMatrixContactExceptions]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- R.Dixon:		25/05/2017 JIRA: DAP-867 Inserts new Contact Exceptions into ContactOverride table
-- V.Khatri:	08/05/2018 JIRA: DAP-1760 Added MailingStreet, MailingCity, MailingState, MailingPostcode and MailingCountry
-- V.Khatri:	26/06/2018 JIRA: DAP-1760 - Removed mailing address info.
-- R.Dixon:		21/08/2018 JIRA: DAP-1753 - Populate Mover field in Sales.BP.AccountOverride, added AccountSivId exceptions
-- R Walker:	23/10/2018 JIRA: DAP-2386 - Investigate why some Exception Overrides aren't persisting - Automatically choose Matrix for Salutations
-------------------------------------------------------------------------------------- 
BEGIN TRY
SET NOCOUNT ON;
SET XACT_ABORT ON;
DECLARE @strProcedureName VARCHAR(100) = '[Sales.BP].[usp_InsertSalesforceMatrixContactExceptions]';
BEGIN TRANSACTION

-- Do to performance issues, we will use a temporary table to store data from [Sales.BP].[ExceptionsContactVw]
IF OBJECT_ID('tempdb..#ExceptionsContactVw') IS NOT NULL
    DROP TABLE #ExceptionsContactVw

select	sf_AccountSivId,
		mx_AccountSivId,
		sf_AccountId,
		sf_Contactid,
		sf_ContactMatrixId,
		sf_FCAid,
		sf_AccountFcaId,
		mx_ContactOwnerId,
		sf_ContactOwnerId,
		sf_Salutation,
		mx_Salutation,
		sf_FirstName,
		mx_FirstName,
		sf_LastName,
		mx_LastName,
		sf_Phone,
		mx_Phone,
		sf_Mobile,
		mx_Mobile,
		sf_emailAddress,
		mx_emailAddress,
		SF_ActiveStatus,
		MX_ActiveStatus,
		CAST(0 AS bit) AS Mover
into #ExceptionsContactVw
from [Sales.BP].[ExceptionsContactVw]

UPDATE	#EXCEPTIONSCONTACTVW
SET		Mover = 1
WHERE	Sf_ContactId IN (SELECT	CntSalesforceId 
						FROM	T_MATRIX_PROCESS_SALESFORCE_CONTACT 
						WHERE	ExportStatus = 'movers')


INSERT [Sales.BP].ContactOverride
(sf_SfAccountId, sf_SfContactId, DataField, sf_FcaId, sf_ContractMatrixId, sf_AccountFcaId, sf_LastName, sf_FirstName, sf_Value, mx_Value, OverrideStatus, OverrideChoice, Mover)
(
--Salutation
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'Salutation' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_Salutation AS [sf_Value],
				ex.mx_Salutation AS [mx_Value],
				'Fixed' AS [OverrideStatus],
				'Matrix' AS [OverrideChoice],	-- Auto select 'Matrix' Salutation
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'Salutation'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_Salutation  <> ex.mx_Salutation
		AND		CO.sf_SfContactId is NULL
UNION
--Contact Owner
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'ContactOwnerId' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_ContactOwnerId AS [sf_Value],
				ex.mx_ContactOwnerId AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'ContactOwnerId'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_ContactOwnerId  <> ex.mx_ContactOwnerId
		AND		CO.sf_SfContactId is NULL
UNION
--First Name
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'FirstName' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_FirstName AS [sf_Value],
				ex.mx_FirstName AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'FirstName'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_FirstName  <> ex.mx_FirstName
		AND		CO.sf_SfContactId is NULL
UNION
--Last Name
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'LastName' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_LastName AS [sf_Value],
				ex.mx_lastName AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'LastName'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_LastName  <> ex.mx_LastName
		AND		CO.sf_SfContactId is NULL


UNION
--Phone
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'Phone' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_Phone AS [sf_Value],
				ex.mx_Phone AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'Phone'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_Phone <> ex.mx_Phone
		AND		CO.sf_SfContactId is NULL
UNION
--Mobile
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'Mobile' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_Mobile AS [sf_Value],
				ex.mx_Mobile AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'Mobile'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_Mobile <> ex.mx_Mobile
		AND		CO.sf_SfContactId is NULL

UNION
--EmailAddress
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'EmailAddress' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_emailAddress AS [sf_Value],
				ex.mx_emailAddress AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'EmailAddress'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_emailAddress <> ex.mx_emailAddress
		AND		CO.sf_SfContactId is NULL

UNION
--ActiveStatus
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'ActiveStatus' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_ActiveStatus AS [sf_Value],
				ex.mx_ActiveStatus AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'ActiveStatus'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_ActiveStatus <> ex.mx_ActiveStatus
		AND		CO.sf_SfContactId is NULL
UNION
-- ContactAccountSivId
		SELECT	ex.sf_AccountId,
				ex.sf_ContactId,
				'ContactAccountId' AS [DataField],
				ex.sf_FcaId, 
				ex.sf_ContactMatrixId, 
				ex.sf_AccountFcaId,
				sf.LastName,
				sf.FirstName,
				ex.sf_AccountSivId AS [sf_Value],
				ex.mx_AccountSivId AS [mx_Value],
				'Raised' AS [OverrideStatus],
				NULL AS [OverrideChoice],
				ex.Mover
		FROM	#ExceptionsContactVw ex
		INNER	JOIN [Sales.BP].[sfContactvw] sf
		ON		sf.sfcontactId = ex.sf_ContactId
		LEFT	OUTER JOIN [Sales.BP].ContactOverride CO
		ON		CO.DataField = 'ContactAccountId'
		AND		CO.sf_SfContactId = ex.sf_Contactid
		WHERE	ex.sf_AccountSivId  <> ex.mx_AccountSivId
		AND		CO.sf_SfContactId is NULL
		AND		ex.Mover = 1

)


COMMIT TRANSACTION
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
ROLLBACK TRANSACTION;

-- Write errors to table: dbo.LogProcErrors
EXECUTE dbo.usp_LogProcErrors

END CATCH


