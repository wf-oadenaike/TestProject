
-------------------------------------------------------------------------------------- 
-- Name: Matrix_AccountVw
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- Matrix account to Salesforce friendly name
-- 
--------------------------------------------------------------------------------------

Create view dbo.[ZZZ_Matrix_AccountVw]
as
	SELECT SALESFORCE_ACCOUNT_ID			as AccSalesForceID,
		   MX_MATRIX_ACCOUNT_SIV_ID			as AccSivID,
		   MX_MATRIX_OUTLET_ID				as AccMatrixOutletID,
		   MX_PARENT_ACCOUNT_SIV_ID			as AccParentSivID,
		   MX_OWNER_ID						as AccOwnerID,
		   MX_OWNER_NAME					as AccOwnerName,
		   MX_NAME							as AccName,
		   MX_OUTLET_TYPE					as AccOutletType,
		   MX_BILLINGSTREET					as AccBillingStreet,
		   MX_BILLINGCITY					as AccBillingCity,
		   MX_BILLINGSTATE					as AccBillingState,
		   MX_POSTALCODE					as AccBillingPostcode,
		   MX_COUNTRY						as AccBillingCountry,
		   MX_PHONE							as AccLandline,
		   MX_FAX							as AccFax,
		   MX_WEBSITE						as AccWebsite,
		   MX_FIRM_SEGMENT					as AccFirmSegment,
		   MX_PLATFORMS_USED				as AccPlatformsUsed,
		   MX_AUTHORISATION_STATUS			as AccAuthStatus,
		   MX_PRIMARY_BUSINESS				as PrimaryBusiness,
		   MX_VERIFIED_BY					as AccVerifiedBy,
		   MX_EXISTING_COMPANY_RELATIONSHIP	as AccExistingCompanyRelationship,
		   MX_ACCOUNT_FSR_FRN				as AccountFsrFrn,
		   AS_AT_DATE						as AsAtDate
FROM [dbo].[T_MATRIX_ACCOUNT]
