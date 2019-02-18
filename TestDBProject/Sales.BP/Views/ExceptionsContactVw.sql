
CREATE view  [Sales.BP].[ExceptionsContactVw]
AS
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------- 
-- Name: Contact View - [Sales.BP].[ExceptionsContactVw]
-- Object: View

-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi,	10/06/2017 Reads Contacts exceptions from the Matrix and Salesforce account tables
-- Vipul Khatri,	22/05/2018 Added extra field to add to exception screen.
-- Vipul Khatri,	20/06/2018 DAP-2124 - Excluded duplicate contacts and movers
-- Vipul Khatri,	26/06/2018 DAP-1760 - Removed mailing address info.
-- Vipul Khatri,	24/07/2018 DAP-2216 - Remove movers from exception process and use contactownerid from postcode mapping logic.
-- Rob Walker,		31/07/2018 DAP-2241 - Prevent exceptions processes for contacts and accounts picking up the wrong owner details
-- Richard Dixon,	21/08/2018 DAP-1753 - Remove logic that excludes movers from exception process - include differences in AccountSivId
-------------------------------------------------------------------------------------- 

SELECT 
		sf.AccountSivId AS sf_AccountSivId,
		mx.AccountSivId AS mx_AccountSivId,
		sf.SfAccountId     AS sf_AccountId,
       sf.SfContactId     AS sf_Contactid,
       sf.ContactMatrixId AS sf_ContactMatrixId,
       sf.FcaId           AS sf_FCAid,
	   sf.AccountFcaId	  as sf_AccountFcaId,
	   T.CntOwnerId as mx_ContactOwnerId,
	   sf.ContactOwnerId  as sf_ContactOwnerId,
       ISNULL(sf.Salutation,'')     AS sf_Salutation,
       mx.Salutation      AS mx_Salutation,
       ISNULL(sf.FirstName,'')      AS sf_FirstName,
       mx.FirstName       AS mx_FirstName,
       ISNULL(sf.LastName,'')        AS sf_LastName,
       mx.LastName        AS mx_LastName,
       sf.Phone           AS sf_Phone,
       mx.Phone           AS mx_Phone,
       sf.Mobile          AS sf_Mobile,
       mx.Mobile          AS mx_Mobile,
       sf.EmailAddress    AS sf_emailAddress,
       mx.EmailAddress    AS mx_emailAddress,
	   ISNULL(sf.IsActive, '')		  AS SF_ActiveStatus,
	   case when (mx.MFidStatus = 'Active' and sf.IsActive is null)   -- This is handled in the feed and we don't want an exception for it
			then ''
			else mx.MFidStatus
	   end					  AS MX_ActiveStatus
FROM [Sales.BP].[SFContactVw] sf
INNER JOIN [Sales.BP].[SFAccountVw] acc
     ON acc.SfAccountId = sf.SfAccountId
INNER JOIN [Sales.BP].[MxContactVw] mx
     ON sf.SfContactId = mx.SfContactId
	 and sf.SfAccountId = mx.SfAccountId  
inner join [Sales.BP].[mxaccountVw] A
	on mx.AccountSivId = a.AccountSivid
INNER JOIN T_MATRIX_PROCESS_SALESFORCE_CONTACT T
ON MX.SfContactId = T.CntSalesforceId
WHERE (acc.IsPriorityClient = 'true'
	OR acc.IsLocked = 'true')
and sf.SfContactId not in (select SALESFORCE_CONTACT_ID from T_MATRIX_DUPLICATECONTACT)  -- Exclude duplicates
-- and sf.SfContactId not in (select CntSalesforceId from T_MATRIX_PROCESS_SALESFORCE_CONTACT where ExportStatus = 'movers') -- Exclude movers
AND (
(ISNULL(sf.Salutation,'') <> mx.Salutation and isNameNull = 0)
OR (ISNULL(sf.FirstName,'') <> mx.FirstName and isNameNull = 0)
OR (ISNULL(sf.LastName,'') <> mx.LastName and isNameNull = 0)
OR sf.Phone <> mx.Phone
OR sf.Mobile <> mx.Mobile
OR sf.EmailAddress <> mx.EmailAddress
OR ISNULL(sf.IsActive,'') <> mx.MfidStatus
OR sf.ContactOwnerId <> T.CntOwnerId	
OR sf.AccountSivId <> mx.AccountSivId
)




