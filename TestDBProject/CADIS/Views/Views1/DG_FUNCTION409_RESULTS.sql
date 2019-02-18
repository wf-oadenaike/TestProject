﻿CREATE VIEW "CADIS"."DG_FUNCTION409_RESULTS" AS 
SELECT ET."DvdForecastCalcOverrideId",ET."FUND_SHORT_NAME",ET."EDM_SEC_ID",ET."SECURITY_NAME",ET."Qtr",ET."EX_DATE",ET."PrevDvdValue",ET."DVD_VALUE",ET."POSITION",ET."DIVIDEND_CCY",ET."WITHHOLDING_TAX",ET."OverrideExDate",ET."OverrideDvdValue",ET."OverrideSpecialCumShares",ET."GrossDvdValue",ET."NetDvdValue",ET."SpecialCumTrades",ET."PrevTotalNetDvd",ET."TotalNetDvd",ET."NTCustodyNetAmountBase",ET."NTCustodyReconDiff",ET."NTCustodyCommentary",ET."NTCustodyDvdChangeReasonId",ET."UseNTCustodyValue",ET."NTFAValueBase",ET."NTFAReconDiff",ET."NTFACommentary",ET."UseNTFAValue",ET."SubmittedByPersonId",ET."OverrideDvdChangeReasonId",ET."OverrideCommentary",ET."IsActive",ET."JoinGUID",ET."DvdForecastCalcOverrideCreationDatetime",ET."DvdForecastCalcOverrideLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Investment"."DvdForecastCalcOverride" ET WITH (NOLOCK)