

CREATE PROC [Olu_2].[USP_Matrix_AccountUpdate]
-------------------------------------------------------------------------------------- 
-- NAME:			[Staging].[USP_Matrix_AccountUpdate]
-- 
-- NOTE:			Update staging table for Boomi to update into salesforce
-- 
-- AUTHOR:			VIPUL KHATRI
-- DATE:			16/04/2018
-------------------------------------------------------------------------------------- 
-- DESCRIPTION:		Update staging table fro Boomi to update into salesforce
-- HISTORY:			
-- 16-04-2018		VIPUL KHATRI			DAP-1753      -- Update staging table for Boomi to update into salesforce

AS

BEGIN TRY

	--- MATRIX_ACCOUNT DATA EXCLUDING DUPLICATES. 
	IF OBJECT_ID('TEMPDB..#MATRIX_ACCOUNT') IS NOT NULL
		 DROP TABLE #MATRIX_ACCOUNT

	SELECT SALESFORCE_ACCOUNT_ID			as ACCSALESFORCEID,
		   MX_MATRIX_ACCOUNT_SIV_ID			as ACCSIVID,
		   MX_MATRIX_OUTLET_ID				as ACCMATRIXOUTLETID,
		   MX_PARENT_ACCOUNT_SIV_ID			as ACCPARENTSIVID,
		   MX_OWNER_ID						as ACCOWNERID,
		   MX_OWNER_NAME					as ACCOWNERNAME,
		   MX_NAME							as ACCNAME,
		   MX_OUTLET_TYPE					as ACCOUTLETTYPE,
		   MX_BILLINGSTREET					as ACCBILLINGSTREET,
		   MX_BILLINGCITY					as ACCBILLINGCITY,
		   MX_BILLINGSTATE					as ACCBILLINGSTATE,
		   MX_POSTALCODE					as ACCBILLINGPOSTCODE,
		   MX_COUNTRY						as ACCBILLINGCOUNTRY,
		   MX_PHONE							as ACCLANDLINE,
		   MX_FAX							as ACCFAX,
		   MX_WEBSITE						as ACCWEBSITE,
		   MX_FIRM_SEGMENT					as ACCFIRMSEGMENT,
		   MX_PLATFORMS_USED				as ACCPLATFORMSUSED,
		   MX_AUTHORISATION_STATUS			as ACCAUTHSTATUS,
		   MX_PRIMARY_BUSINESS				as PRIMARYBUSINESS,
		   MX_VERIFIED_BY					as ACCVERIFIEDBY,
		   MX_EXISTING_COMPANY_RELATIONSHIP	as ACCEXISTINGCOMPANYRELATIONSHIP,
		   MX_ACCOUNT_FSR_FRN				as ACCOUNTFSRFRN,
		   AS_AT_DATE						as ASATDATE
	INTO #MATRIX_ACCOUNT
	FROM [Olu].[ACCOUNT]
	WHERE SALESFORCE_ACCOUNT_ID NOT IN (
		 SELECT DISTINCT SALESFORCE_ACCOUNT_ID
		 FROM STAGING.T_MATRIX_DUPLICATE_ACCOUNT
	)

	--- SFACCOUNTRAW UNLOCKED ACCOUNTS WITHOUT PRIORITY. 
	IF OBJECT_ID('TEMPDB..#SFACCOUNTRAW') IS NOT NULL
		 DROP TABLE #SFACCOUNTRAW

	SELECT ACCSALESFORCEID,
		   ACCSIVID,
		   ACCMATRIXOUTLETID,
		   ACCPARENTSIVID,
		   ACCOWNERID,
		   ACCOWNERNAME,
		   ACCNAME,
		   ACCOUTLETTYPE,
		   ACCBILLINGSTREET,
		   ACCBILLINGCITY,
		   ACCBILLINGSTATE,
		   ACCBILLINGPOSTCODE,
		   ACCBILLINGCOUNTRY,
		   ACCLANDLINE,
		   ACCFAX,
		   ACCWEBSITE,
		   ACCEMAIL,
		   ACCFIRMSEGMENT,
		   ACCPLATFORMSUSED,
		   ACCAUTHSTATUS,
		   MX_PRIMARY_BUSINESS				as PRIMARYBUSINESS,
		   ACCVERIFIEDBY,
		   ACCEXISTINGCOMPANYRELATIONSHIP,
		   ACCPRIORITYCLIENT,
		   ACCISLOCKED
	INTO #SFACCOUNTRAW
	FROM [STAGING.SALESFORCE.BP].[SFACCOUNTRAW]
	WHERE ACCPRIORITYCLIENT = 'FALSE'
	AND ACCISLOCKED = 'FALSE'


	-- Truncate previous data
	TRUNCATE TABLE [Staging].Matrix_SF_Account

	-- START TRANSACTION
	BEGIN TRANSACTION

	INSERT INTO [Staging].Matrix_SF_Account
	(
				AccSivId,
				AsAtDate,
				CaseID,
				Type,
				AccFcaID,
				AccSalesForceID,
				AccMatrixOutletId,
				AccParentSivId,
				AccOwnerId,
				AccOwnerName,
				AccName,
				AccOutletType,
				AccBillingStreet,
				AccBillingCity,
				AccBillingState,
				AccBillingPostcode,
				AccBillingCountry,
				AccLandline,
				AccFax,
				AccWebsite,
				AccFirmSegment,
				AccAuthStatus,
				AccPlatformsUsed,
				AccVerifiedBy,
				AccExistingCompanyRelationship,
				AccPriorityClient,
				AccCalculatedPriority,
				AccKeyAccount,
				AccRegionCode,
				AccIsLocked,
				WFPrimaryBusiness,
				MXPrimaryBusiness,
				RecordTypeName,
				AccParentSalesforceId
	)

	-- Case 1
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   1                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   MX.ACCMATRIXOUTLETID                                              AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   MX.ACCOWNERID                                                     AS AccOwnerId,
		   MX.ACCOWNERNAME                                                   AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   REPLACE(REPLACE(MX.ACCBILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   SF.AccPriorityClient                                              AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   SF.ACCISLOCKED                                                    AS AccIsLocked,
		   SF.PRIMARYBUSINESS                                                AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   NULL                                                              AS RecordTypeName,
		   SF.ACCSALESFORCEID                                                AS AccParentSalesforceId
	FROM #MATRIX_ACCOUNT MX
	INNER JOIN #SFACCOUNTRAW SF
		 ON MX.ACCPARENTSIVID = SF.ACCSIVID
		 AND (COALESCE(MX.ACCSIVID, '') <> COALESCE(SF.ACCSIVID, '')
		 OR COALESCE(MX.ACCMATRIXOUTLETID, '') <> COALESCE(SF.ACCMATRIXOUTLETID, '')
		 OR COALESCE(MX.ACCPARENTSIVID, '') <> COALESCE(SF.ACCPARENTSIVID, '')
		 OR COALESCE(MX.ACCOWNERID, '') <> COALESCE(SF.ACCOWNERID, '')
		 OR COALESCE(MX.ACCOWNERNAME, '') <> COALESCE(SF.ACCOWNERNAME, '')
		 OR COALESCE(MX.ACCNAME, '') <> COALESCE(SF.ACCNAME, '')
		 OR COALESCE(MX.ACCOUTLETTYPE, '') <> COALESCE(SF.ACCOUTLETTYPE, '')
		 OR COALESCE(MX.ACCBILLINGSTREET, '') <> COALESCE(SF.ACCBILLINGSTREET, '')
		 OR COALESCE(MX.ACCBILLINGCITY, '') <> COALESCE(SF.ACCBILLINGCITY, '')
		 OR COALESCE(MX.ACCBILLINGSTATE, '') <> COALESCE(SF.ACCBILLINGSTATE, '')
		 OR COALESCE(MX.ACCBILLINGPOSTCODE, '') <> COALESCE(SF.ACCBILLINGPOSTCODE, '')
		 OR COALESCE(MX.ACCBILLINGCOUNTRY, '') <> COALESCE(SF.ACCBILLINGCOUNTRY, '')
		 OR COALESCE(MX.ACCLANDLINE, '') <> COALESCE(SF.ACCLANDLINE, '')
		 OR COALESCE(MX.ACCFAX, '') <> COALESCE(SF.ACCFAX, '')
		 OR COALESCE(MX.ACCWEBSITE, '') <> COALESCE(SF.ACCWEBSITE, '')
		 OR COALESCE(MX.ACCFIRMSEGMENT, '') <> COALESCE(SF.ACCFIRMSEGMENT, '')
		 OR COALESCE(MX.ACCPLATFORMSUSED, '') <> COALESCE(SF.ACCPLATFORMSUSED, '')
		 OR COALESCE(MX.ACCAUTHSTATUS, '') <> COALESCE(SF.ACCAUTHSTATUS, '')
		 OR COALESCE(MX.PRIMARYBUSINESS, '') <> COALESCE(SF.PRIMARYBUSINESS, '')
		 OR COALESCE(MX.ACCVERIFIEDBY, '') <> COALESCE(SF.ACCVERIFIEDBY, '')
		 OR COALESCE(MX.ACCEXISTINGCOMPANYRELATIONSHIP, '') <> COALESCE(SF.ACCEXISTINGCOMPANYRELATIONSHIP, '')
		 )
	WHERE MX.ACCPARENTSIVID IS NOT NULL

	UNION

	-- Case 2
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   2                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   MX.ACCMATRIXOUTLETID                                              AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   MX.ACCOWNERID                                                     AS AccOwnerId,
		   MX.ACCOWNERNAME                                                   AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   REPLACE(REPLACE(MX.ACCBILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   NULL                                                              AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   NULL																 AS AccIsLocked,
		   NULL																 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   NULL                                                              AS RecordTypeName,
		   NULL																 AS AccParentSalesforceId
	FROM #MATRIX_ACCOUNT MX
	WHERE MX.ACCPARENTSIVID IS NULL
	AND	  MX.ACCSALESFORCEID != ''

	UNION

	-- CASE 3
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   3                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   MX.ACCMATRIXOUTLETID                                              AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   MX.ACCOWNERID                                                     AS AccOwnerId,
		   MX.ACCOWNERNAME                                                   AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   REPLACE(REPLACE(MX.ACCBILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   SF.AccPriorityClient                                              AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   SF.ACCISLOCKED                                                    AS AccIsLocked,
		   SF.PRIMARYBUSINESS                                                AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   NULL                                                              AS RecordTypeName,
		   SF.ACCSALESFORCEID                                                AS AccParentSalesforceId
	FROM #MATRIX_ACCOUNT MX
	INNER JOIN #SFACCOUNTRAW SF
		 ON MX.ACCPARENTSIVID = SF.ACCSIVID
		 AND (COALESCE(MX.ACCSIVID, '') <> COALESCE(SF.ACCSIVID, '')
		 OR COALESCE(MX.ACCMATRIXOUTLETID, '') <> COALESCE(SF.ACCMATRIXOUTLETID, '')
		 OR COALESCE(MX.ACCPARENTSIVID, '') <> COALESCE(SF.ACCPARENTSIVID, '')
		 OR COALESCE(MX.ACCOWNERID, '') <> COALESCE(SF.ACCOWNERID, '')
		 OR COALESCE(MX.ACCOWNERNAME, '') <> COALESCE(SF.ACCOWNERNAME, '')
		 OR COALESCE(MX.ACCNAME, '') <> COALESCE(SF.ACCNAME, '')
		 OR COALESCE(MX.ACCOUTLETTYPE, '') <> COALESCE(SF.ACCOUTLETTYPE, '')
		 OR COALESCE(MX.ACCBILLINGSTREET, '') <> COALESCE(SF.ACCBILLINGSTREET, '')
		 OR COALESCE(MX.ACCBILLINGCITY, '') <> COALESCE(SF.ACCBILLINGCITY, '')
		 OR COALESCE(MX.ACCBILLINGSTATE, '') <> COALESCE(SF.ACCBILLINGSTATE, '')
		 OR COALESCE(MX.ACCBILLINGPOSTCODE, '') <> COALESCE(SF.ACCBILLINGPOSTCODE, '')
		 OR COALESCE(MX.ACCBILLINGCOUNTRY, '') <> COALESCE(SF.ACCBILLINGCOUNTRY, '')
		 OR COALESCE(MX.ACCLANDLINE, '') <> COALESCE(SF.ACCLANDLINE, '')
		 OR COALESCE(MX.ACCFAX, '') <> COALESCE(SF.ACCFAX, '')
		 OR COALESCE(MX.ACCWEBSITE, '') <> COALESCE(SF.ACCWEBSITE, '')
		 OR COALESCE(MX.ACCFIRMSEGMENT, '') <> COALESCE(SF.ACCFIRMSEGMENT, '')
		 OR COALESCE(MX.ACCPLATFORMSUSED, '') <> COALESCE(SF.ACCPLATFORMSUSED, '')
		 OR COALESCE(MX.ACCAUTHSTATUS, '') <> COALESCE(SF.ACCAUTHSTATUS, '')
		 OR COALESCE(MX.PRIMARYBUSINESS, '') <> COALESCE(SF.PRIMARYBUSINESS, '')
		 OR COALESCE(MX.ACCVERIFIEDBY, '') <> COALESCE(SF.ACCVERIFIEDBY, '')
		 OR COALESCE(MX.ACCEXISTINGCOMPANYRELATIONSHIP, '') <> COALESCE(SF.ACCEXISTINGCOMPANYRELATIONSHIP, '')
		 )
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND MX.ACCSALESFORCEID = ''

	UNION

	-- Case 4
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   4                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   MX.ACCMATRIXOUTLETID                                              AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   MX.ACCOWNERID                                                     AS AccOwnerId,
		   MX.ACCOWNERNAME                                                   AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   REPLACE(REPLACE(MX.ACCBILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   NULL                                                              AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   NULL																 AS AccIsLocked,
		   NULL																 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   NULL                                                              AS RecordTypeName,
		   NULL																 AS AccParentSalesforceId
	FROM #MATRIX_ACCOUNT MX
	WHERE MX.ACCPARENTSIVID IS NULL
	AND   MX.ACCSALESFORCEID = ''

	UNION

	-- Case 5
	SELECT MX.ACCSIVID                                                       AS AccSivId,
		   MX.ASATDATE                                                       AS AsAtDate,
		   5                                                                 AS CaseID,
		   'ACCOUNT'                                                         AS Type,
		   MX.ACCOUNTFSRFRN                                                  AS AccFcaID,
		   MX.ACCSALESFORCEID                                                AS AccSalesForceID,
		   MX.ACCMATRIXOUTLETID                                              AS AccMatrixOutletId,
		   MX.ACCPARENTSIVID                                                 AS AccParentSivId,
		   MX.ACCOWNERID                                                     AS AccOwnerId,
		   MX.ACCOWNERNAME                                                   AS AccOwnerName,
		   MX.ACCNAME                                                        AS AccName,
		   MX.ACCOUTLETTYPE                                                  AS AccOutletType,
		   REPLACE(REPLACE(MX.ACCBILLINGSTREET, CHAR(13), ''), CHAR(10), '') AS AccBillingStreet,
		   MX.ACCBILLINGCITY                                                 AS AccBillingCity,
		   MX.ACCBILLINGSTATE                                                AS AccBillingState,
		   MX.ACCBILLINGPOSTCODE                                             AS AccBillingPostcode,
		   MX.ACCBILLINGCOUNTRY                                              AS AccBillingCountry,
		   MX.ACCLANDLINE                                                    AS AccLandline,
		   MX.ACCFAX                                                         AS AccFax,
		   MX.ACCWEBSITE                                                     AS AccWebsite,
		   MX.ACCFIRMSEGMENT                                                 AS AccFirmSegment,
		   MX.ACCAUTHSTATUS                                                  AS AccAuthStatus,
		   MX.ACCPLATFORMSUSED                                               AS AccPlatformsUsed,
		   MX.ACCVERIFIEDBY                                                  AS AccVerifiedBy,
		   MX.ACCEXISTINGCOMPANYRELATIONSHIP                                 AS AccExistingCompanyRelationship,
		   NULL																 AS AccPriorityClient,
		   NULL                                                              AS AccCalculatedPriority,
		   NULL                                                              AS AccKeyAccount,
		   NULL                                                              AS AccRegionCode,
		   NULL																 AS AccIsLocked,
		   NULL																 AS WFPrimaryBusiness,
		   MX.PRIMARYBUSINESS                                                AS MXPrimaryBusiness,
		   NULL                                                              AS RecordTypeName,
		   NULL																 AS AccParentSalesforceId
	FROM #MATRIX_ACCOUNT MX
	LEFT OUTER JOIN [STAGING.SALESFORCE.BP].[SFACCOUNTRAW]  R   -- Using main table to avoid rows being eliminated via a left join
			  ON mx.ACCPARENTSIVID = R.ACCSIVID
	WHERE MX.ACCPARENTSIVID IS NOT NULL
	AND   MX.ACCSALESFORCEID  = ''
	AND   r.ACCSALESFORCEID IS NULL

	COMMIT TRAN -- Transaction Success!

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN --RollBack in case of Error

    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY()

    RAISERROR(@ErrorMessage, @ErrorSeverity, 1)

END CATCH
