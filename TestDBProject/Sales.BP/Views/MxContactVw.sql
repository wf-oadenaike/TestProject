

CREATE VIEW [Sales.BP].[MxContactVw]
	AS

-------------------------------------------------------------------------------------- 
-- WHO WHEN WHY
-- Vipul Khatri  09/05/2018 DAP-1929  - Matrix Contact feed.
-------------------------------------------------------------------------------------- 

SELECT SALESFORCE_CONTACT_ID                                 AS SfContactId,
	   AS_AT_DATE											 AS AsAtDate,
       SALESFORCE_ACCOUNT_ID								 AS SfAccountId,
       MX_LAST_NAME                                          AS LastName,
       MX_FIRST_NAME                                         AS FirstName,
       MX_SALUTATION                                         AS Salutation,
       MX_TITLE                                              AS JobTitle,
       MX_CONTACT_FSR_IRN                                    AS FcaId,
       NULLIF(MX_ACCOUNT_FSR_FRN, 'unclassified')            AS AccountFcaId,
       MX_OWNER_ID                                           AS ContactOwnerId,
       MX_OWNER_NAME                                         AS ContactOwnerName,
       MX_ACCOUNT_SIV_ID                                     AS AccountSivId,
       MX_CONTACT_SIV_ID                                     AS ContactSivId,
       MX_MATRIX_CONTACT_ID                                  AS ContactMatrixId,
       NULLIF(MX_MAILING_STREET, 'unclassified')             AS MailingStreet,
       NULLIF(MX_MAILING_CITY, 'unclassified')               AS MailingCity,
       NULLIF(MX_MAILING_STATE, 'unclassified')              AS MailingState,
       NULLIF(MX_MAILING_POSTCODE, 'unclassified')           AS MailingPostcode,
	   left(NULLIF(MX_MAILING_POSTCODE, 'unclassified') ,len(MX_MAILING_POSTCODE)-2)  AS MailingPostcodeMapping,
       NULLIF(MX_MAILING_COUNTRY, 'unclassified')            AS MailingCountry,
       MX_PHONE                                              AS Phone,
       MX_MOBILE_PHONE                                       AS Mobile,
       MX_FAX                                                AS Fax,
       MX_EMAIL                                              AS EmailAddress,
       CASE
            WHEN MX_CONTACT_IS_CF1 = 'Y' THEN 'true'
			WHEN MX_CONTACT_IS_CF1 = 'N' THEN 'false'
       END                                                   AS IsCf1,
       CASE
            WHEN MX_CONTACT_IS_CF2 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF2 = 'N' THEN 'false'
       END                                                   AS IsCf2,
       CASE
            WHEN MX_CONTACT_IS_CF3 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF3 = 'N' THEN 'false'
       END                                                   AS IsCf3,
       CASE
            WHEN MX_CONTACT_IS_CF4 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF4 = 'N' THEN 'false'
       END                                                   AS IsCf4,
       CASE
            WHEN MX_CONTACT_IS_CF10 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF10 = 'N' THEN 'false'
       END                                                   AS IsCf10,
       CASE
            WHEN MX_CONTACT_IS_CF11 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF11 = 'N' THEN 'false'
       END                                                   AS IsCf11,
       CASE
            WHEN MX_CONTACT_IS_CF30 = 'Y' THEN 'true'
			when MX_CONTACT_IS_CF30 = 'N' THEN 'false'
       END                                                   AS IsCf30,
       MX_VERIFIED_BY                                        AS VerifiedBy,
	   CASE WHEN MX_MFID_STATUS = 'ACTIVE'
				THEN 1
			WHEN MX_MFID_STATUS = 'INACTIVE'
				THEN 0
		END													AS IsActive,
		NULLIF(MX_FCA_STATUS,'UNCLASSIFIED')				as FCAStatus,
	    NULLIF(MX_MFID_STATUS,'UNCLASSIFIED')				as MfidStatus								
	FROM [dbo].[T_MATRIX_CONTACT]