
-------------------------------------------------------------------------------------- 
-- Name: Matrix_ContactVw
-- Object: View
-- 
-------------------------------------------------------------------------------------- 
-- Matrix contact to Salesforce friendly name
-- 
--------------------------------------------------------------------------------------

Create view dbo.[ZZZ_Matrix_ContactVw]
as

	SELECT SALESFORCE_CONTACT_ID AS CntSalesforceId,
			SALESFORCE_ACCOUNT_ID AS CntAccountSalesforceId,
			MX_CONTACT_FSR_IRN AS CntFcaId,
			MX_ACCOUNT_FSR_FRN AS CntAccountFcaId,
			MX_OWNER_ID AS CntOwnerId,
			MX_OWNER_NAME AS CntOwnerName,
			MX_ACCOUNT_SIV_ID AS CntAccountSivId,
			MX_CONTACT_SIV_ID AS CntSivId,
			MX_MATRIX_CONTACT_ID AS CntMatrixId,
			MX_SALUTATION AS CntSalutation,
			MX_FIRST_NAME AS CntFirstName,
			MX_LAST_NAME AS CntLastName,
			MX_TITLE AS CntJobTitle,
			MX_MAILING_STREET AS CntMailingStreet,
			MX_MAILING_CITY AS CntMailingCity,
			MX_MAILING_STATE AS CntMailingState,
			MX_MAILING_POSTCODE AS CntMailingPostcode,
			MX_MAILING_COUNTRY AS CntMailingCountry,
			MX_PHONE AS CntLandline,
			MX_MOBILE_PHONE AS CntMobile,
			MX_FAX AS CntFax,
			MX_EMAIL AS CntEmail,
			MX_CONTACT_IS_CF1 AS CntIsCf1,
			MX_CONTACT_IS_CF2 AS CntIsCf2,
			MX_CONTACT_IS_CF3 AS CntIsCf3,
			MX_CONTACT_IS_CF4 AS CntIsCf4,
			MX_CONTACT_IS_CF10 AS CntIsCf10,
			MX_CONTACT_IS_CF11 AS CntIsCf11,
			MX_CONTACT_IS_CF30 AS CntIsCf30,
			MX_VERIFIED_BY AS CntVerifiedBy,
			AS_AT_DATE		as AsAtDate
	FROM [dbo].[T_MATRIX_CONTACT]
