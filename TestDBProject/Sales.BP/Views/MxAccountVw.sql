

-------------------------------------------------------------------------------------- 
-- Name: Accont View - [Sales.BP].[MxAccountVw]
-- Object: View

-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Reads Account data from new Matrix account table
-- Vipul Khatri	24/04/2018	 -- Changed code to use new Matrix tables.
-- Vipul Khatri 23/05/2018   -- DAP-1928 - Add patch bad data from Matrix.
-- Vipul Khatri 20/07/2018   -  DAP-2195 - Amended BillingPostcodeMapping to use WF_BILLING_POSTCODE. 
-------------------------------------------------------------------------------------- 

CREATE VIEW [Sales.BP].[MxAccountVw]
as

SELECT SALESFORCE_ACCOUNT_ID                           AS SfAccountId,
       AS_AT_DATE                                      AS AsAtDate,
       MX_NAME                                         AS AccountName,
       NULLIF(MX_ACCOUNT_FSR_FRN, 'unclassified') 	   AS FcaId,
       MX_MATRIX_OUTLET_ID                             AS MatrixOutletId,
       NULLIF(MX_OUTLET_TYPE, 'unclassified')          AS OutletType,
       MX_MATRIX_ACCOUNT_SIV_ID                        AS AccountSivId,
       MX_PARENT_ACCOUNT_SIV_ID                        AS ParentAccountSivId,
       MX_OWNER_ID                                     AS AccountOwnerId,
       MX_OWNER_NAME                                   AS AccountOwnerName,
       NULLIF(MX_PHONE, 'unclassified')                AS Phone,
       NULLIF(MX_FAX, 'unclassified')                  AS Fax,
       NULLIF(MX_WEBSITE, 'unclassified')              AS Website,
       NULL                                            AS EmailAddress,
       NULLIF(MX_FIRM_SEGMENT, 'unclassified')         AS FirmSegment,
       NULLIF(MX_PLATFORMS_USED, 'unclassified')       AS PlatformsUsed,
       NULLIF(MX_AUTHORISATION_STATUS, 'unclassified') AS AuthStatus,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE NULLIF(MX_BILLINGSTREET, 'unclassified')
       END                                             AS BillingStreet,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE NULLIF(MX_BILLINGCITY, 'unclassified')
       END                                             AS BillingCity,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE NULLIF(MX_BILLINGSTATE, 'unclassified')
       END                                             AS BillingState,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE NULLIF(MX_POSTALCODE, 'unclassified')
       END                                             AS BillingPostcode,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE LEFT(NULLIF(isnull(MX_POSTALCODE,case when len(WF_BILLING_POSTCODE ) <= 8 then WF_BILLING_POSTCODE end), 'unclassified'), LEN(NULLIF(isnull(MX_POSTALCODE,case when len(WF_BILLING_POSTCODE ) <= 8 then WF_BILLING_POSTCODE end), 'unclassified')) - 2)
       END                                             AS BillingPostcodeMapping,
       CASE
            WHEN (MX_BILLINGSTREET = 'NOT KNOWN' OR
                 MX_BILLINGCITY = 'NOT KNOWN' OR
                 MX_BILLINGSTATE = 'NOT KNOWN' OR
                 MX_POSTALCODE = 'NOT KNOWN' OR
                 MX_COUNTRY = 'NOT KNOWN') THEN NULL
            ELSE NULLIF(MX_COUNTRY, 'unclassified')
       END                                             AS BillingCountry,
       MX_VERIFIED_BY                                  AS VerifiedBy,
       MX_EXISTING_COMPANY_RELATIONSHIP                AS IsExistingCompanyRelationship,
       isnull(WF_PRIMARY_BUSINESS,MX_PRIMARY_BUSINESS) AS WF_PRIMARY_BUSINESS,
       MX_PRIMARY_BUSINESS                             MX_PRIMARY_BUSINESS,
       CASE
            WHEN MX_MFID_STATUS = 'ACTIVE' THEN 1
            WHEN MX_MFID_STATUS = 'INACTIVE' THEN 0
       END                                             AS IsActive,
       NULLIF(MX_FCA_STATUS, 'unclassified')                                   AS FCAStatus,
       NULLIF(MX_MFID_STATUS, 'unclassified')                                  AS MfidStatus,
	   CASE 
						WHEN MX_PARENT_ACCOUNT_SIV_ID IS NOT NULL THEN 'Outlet' 
						ELSE 'Head Office' 
		END																		AS RecordTypeName
FROM [dbo].[T_MATRIX_ACCOUNT]

