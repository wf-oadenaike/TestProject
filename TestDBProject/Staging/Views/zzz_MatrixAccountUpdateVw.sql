
CREATE VIEW [Staging].[zzz_MatrixAccountUpdateVw]
AS

     SELECT MX.SALESFORCE_ACCOUNT_ID,
            MX.ACCOUNT_SIV_ID,
            MX.MATRIX_OUTLET_ID,
            MX.PARENT_ACCOUNT_SIV_ID,
            MX.OWNER_ID,
            MX.OWNER_NAME,
            MX.NAME,
            MX.OUTLET_TYPE,
            MX.BILLING_STREET,
            MX.BILLING_CITY,
            MX.BILLING_STATE,
            MX.BILLING_POSTCODE,
            MX.BILLING_COUNTRY,
            MX.BILLING_PHONE,
            MX.FAX,
            MX.WEBSITE,
            MX.FIRM_SEGMENT,
            MX.PLATFORMS_USED,
            MX.AUTHORISATION_STATUS,
            MX.PRIMARY_BUSINESS,
            MX.VERIFIED_BY,
            MX.EXISTING_COMPANY_RELATIONSHIP
     FROM (
          SELECT SALESFORCE_ACCOUNT_ID,
                 MX_MATRIX_ACCOUNT_SIV_ID         AS ACCOUNT_SIV_ID,
                 MX_MATRIX_OUTLET_ID              AS MATRIX_OUTLET_ID,
                 MX_PARENT_ACCOUNT_SIV_ID         AS PARENT_ACCOUNT_SIV_ID,
                 MX_OWNER_ID                      AS OWNER_ID,
                 MX_OWNER_NAME                    AS OWNER_NAME,
                 MX_NAME                          AS NAME,
                 MX_OUTLET_TYPE                   AS OUTLET_TYPE,
                 MX_BILLINGSTREET                 AS BILLING_STREET,
                 MX_BILLINGCITY                   AS BILLING_CITY,
                 MX_BILLINGSTATE                  AS BILLING_STATE,
                 MX_POSTALCODE                    AS BILLING_POSTCODE,
                 MX_COUNTRY                       AS BILLING_COUNTRY,
                 MX_PHONE                         AS BILLING_PHONE,
                 MX_FAX                           AS FAX,
                 MX_WEBSITE                       AS WEBSITE,
                 MX_FIRM_SEGMENT                  AS FIRM_SEGMENT,
                 MX_PLATFORMS_USED                AS PLATFORMS_USED,
                 MX_AUTHORISATION_STATUS          AS AUTHORISATION_STATUS,
                 MX_PRIMARY_BUSINESS              AS PRIMARY_BUSINESS,
                 MX_VERIFIED_BY                   AS VERIFIED_BY,
                 MX_EXISTING_COMPANY_RELATIONSHIP AS EXISTING_COMPANY_RELATIONSHIP
          FROM STAGING.T_MATRIX_ACCOUNT
          WHERE SALESFORCE_ACCOUNT_ID <> ''
		  AND	SALESFORCE_ACCOUNT_ID NOT IN (SELECT DISTINCT SALESFORCE_ACCOUNT_ID FROM Staging.T_MATRIX_DUPLICATE_ACCOUNT)
     ) MX
     INNER JOIN (
          SELECT ACCSALESFORCEID                AS SALESFORCE_ACCOUNT_ID,
                 AccSivId                       AS ACCOUNT_SIV_ID,
                 ACCMATRIXOUTLETID              AS MATRIX_OUTLET_ID,
                 ACCPARENTSIVID                 AS PARENT_ACCOUNT_SIV_ID,
                 ACCOWNERID                     AS OWNER_ID,
                 ACCOWNERNAME                   AS OWNER_NAME,
                 ACCNAME                        AS NAME,
                 ACCOUTLETTYPE                  AS OUTLET_TYPE,
                 ACCBILLINGSTREET               AS BILLING_STREET,
                 ACCBILLINGCITY                 AS BILLING_CITY,
                 ACCBILLINGSTATE                AS BILLING_STATE,
                 ACCBILLINGPOSTCODE             AS BILLING_POSTCODE,
                 ACCBILLINGCOUNTRY              AS BILLING_COUNTRY,
                 ACCLANDLINE                    AS BILLING_PHONE,
                 ACCFAX                         AS FAX,
                 ACCWEBSITE                     AS WEBSITE,
                 ACCEMAIL                       AS EMAIL,  -- DOESN'T SEEM TO EXIST
                 ACCFIRMSEGMENT                 AS FIRM_SEGMENT,
                 ACCPLATFORMSUSED               AS PLATFORMS_USED,
                 ACCAUTHSTATUS                  AS AUTHORISATION_STATUS,
                 MX_PRIMARY_BUSINESS            AS PRIMARY_BUSINESS,
                 ACCVERIFIEDBY                  AS VERIFIED_BY,
                 ACCEXISTINGCOMPANYRELATIONSHIP AS EXISTING_COMPANY_RELATIONSHIP,
                 ACCPRIORITYCLIENT              AS PRIORITYCLIENT,
                 ACCISLOCKED                    AS ISLOCKED
          FROM [STAGING.SALESFORCE.BP].[SFACCOUNTRAW]
          WHERE ACCPRIORITYCLIENT = 'FALSE'
          AND ACCISLOCKED = 'FALSE'
     ) SF
          ON MX.SALESFORCE_ACCOUNT_ID = SF.SALESFORCE_ACCOUNT_ID
          AND (COALESCE(MX.ACCOUNT_SIV_ID, '') <> COALESCE(SF.ACCOUNT_SIV_ID, '')
          OR COALESCE(MX.MATRIX_OUTLET_ID, '') <> COALESCE(SF.MATRIX_OUTLET_ID, '')
          OR COALESCE(MX.PARENT_ACCOUNT_SIV_ID, '') <> COALESCE(SF.PARENT_ACCOUNT_SIV_ID, '')
          OR COALESCE(MX.OWNER_ID, '') <> COALESCE(SF.OWNER_ID, '')
          OR COALESCE(MX.OWNER_NAME, '') <> COALESCE(SF.OWNER_NAME, '')
          OR COALESCE(MX.NAME, '') <> COALESCE(SF.NAME, '')
          OR COALESCE(MX.OUTLET_TYPE, '') <> COALESCE(SF.OUTLET_TYPE, '')
          OR COALESCE(MX.BILLING_STREET, '') <> COALESCE(SF.BILLING_STREET, '')
          OR COALESCE(MX.BILLING_CITY, '') <> COALESCE(SF.BILLING_CITY, '')
          OR COALESCE(MX.BILLING_STATE, '') <> COALESCE(SF.BILLING_STATE, '')
          OR COALESCE(MX.BILLING_POSTCODE, '') <> COALESCE(SF.BILLING_POSTCODE, '')
          OR COALESCE(MX.BILLING_COUNTRY, '') <> COALESCE(SF.BILLING_COUNTRY, '')
          OR COALESCE(MX.BILLING_PHONE, '') <> COALESCE(SF.BILLING_PHONE, '')
          OR COALESCE(MX.FAX, '') <> COALESCE(SF.FAX, '')
          OR COALESCE(MX.WEBSITE, '') <> COALESCE(SF.WEBSITE, '')
          OR COALESCE(MX.FIRM_SEGMENT, '') <> COALESCE(SF.FIRM_SEGMENT, '')
          OR COALESCE(MX.PLATFORMS_USED, '') <> COALESCE(SF.PLATFORMS_USED, '')
          OR COALESCE(MX.AUTHORISATION_STATUS, '') <> COALESCE(SF.AUTHORISATION_STATUS, '')
          OR COALESCE(MX.PRIMARY_BUSINESS, '') <> COALESCE(SF.PRIMARY_BUSINESS, '')
          OR COALESCE(MX.VERIFIED_BY, '') <> COALESCE(SF.VERIFIED_BY, '')
          OR COALESCE(MX.EXISTING_COMPANY_RELATIONSHIP, '') <> COALESCE(SF.EXISTING_COMPANY_RELATIONSHIP, '')
          )

