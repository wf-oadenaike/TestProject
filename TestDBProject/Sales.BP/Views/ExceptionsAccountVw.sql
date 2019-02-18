

-------------------------------------------------------------------------------------- 
-- Name: Accont View - [Sales.BP].[ExceptionsAccountVw]
-- Object: View

-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 
-- Reads Account exceptions from the Matrix and Salesforce account tables
-- Vipul Khatri	24/04/2018	 -- Changed code to use new Matrix tables.
-- Vipul Khatri, 20/06/2018  -- DAP-2124 - Excluded duplicate accounts.
-- Vipul Khatri, 24/07/2018  -- DAP-2216 - Use Accountownerid from postcode mapping logic.
-- Rob Walker, 31/07/2018  -- DAP-2241 - Prevent exceptions processes for contacts and accounts picking up the wrong owner details
-------------------------------------------------------------------------------------- 


CREATE view [Sales.BP].[ExceptionsAccountVw] 
AS

SELECT sf.SfAccountId                 AS sf_SfAccountId,
       sf.fcaid                       AS sf_fcaid,
       sf.MatrixOutletId              AS sf_OutletID,
	   sf.accountownerid			  AS sf_accountownerid,
	   T.AccOwnerId					  AS mx_accountownerid,
       sf.AccountName                 AS sf_AccountName,
       mx.AccountName                 AS mx_AccountName,
       ISNULL(sf.BillingStreet, '')   AS sf_BillingStreet,
       mx.BillingStreet               AS mx_BillingStreet,
       ISNULL(sf.BillingCity, '')     AS sf_BillingCity,
       mx.BillingCity                 AS mx_BillingCity,
       ISNULL(sf.BillingPostcode, '') AS sf_BillingPostcode,
       mx.BillingPostcode             AS mx_BillingPostcode,
       ISNULL(sf.BillingCountry, '')  AS sf_BillingCountry,
       mx.BillingCountry              AS mx_BillingCountry,
       sf.Phone                       AS sf_Phone,
       mx.Phone                       AS mx_Phone,
       ISNULL(sf.AccIsActive, '')     AS SF_ActiveStatus,
       case when (mx.MFidStatus = 'Active' and sf.AccIsActive is null)   -- This is handled in the feed and we don't want an exception for it
			then ''
			else mx.MFidStatus
	   end					  AS MX_ActiveStatus
-------------------
FROM [Sales.BP].[sfAccountVw] sf
INNER JOIN [Sales.BP].[MxAccountVw] mx
     ON sf.SfAccountId = mx.SfAccountId
INNER JOIN T_MATRIX_PROCESS_SALESFORCE_ACCOUNT T
	 ON MX.SfAccountId = T.AccSalesForceID
WHERE (sf.IsPriorityClient = 'true'
		OR sf.IsLocked = 'true')
	 AND sf.SfAccountId NOT IN (SELECT SALESFORCE_ACCOUNT_ID FROM T_MATRIX_DUPLICATEACCOUNT)
     AND (
     sf.AccountName <> mx.AccountName
     OR (ISNULL(sf.BillingStreet, '') <> mx.BillingStreet
     AND IsBillingAddressNull = 0)
     OR (ISNULL(sf.BillingCity, '') <> mx.BillingCity
     AND IsBillingAddressNull = 0)
     OR (ISNULL(sf.BillingPostcode, '') <> mx.BillingPostcode
     AND IsBillingAddressNull = 0)
     OR (ISNULL(sf.BillingCountry, '') <> mx.BillingCountry
     AND IsBillingAddressNull = 0)
     OR sf.Phone <> mx.Phone
     OR ISNULL(sf.AccIsActive,'') <> mx.MFidStatus
	 OR sf.accountownerid <> T.AccOwnerId
     )

