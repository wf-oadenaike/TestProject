﻿CREATE VIEW "CADIS"."DG_FUNCTION755_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."EDM_SEC_ID",ET."FUND_FISCAL_YEAR",ET."DVD_CCY",ET."WITHHOLDING_TAX",ET."DECLARED_DATE",ET."POSITION_DATE",ET."POSITION",ET."BID_PRICE",ET."SPOT_RATE",ET."MARKET_VALUE",ET."Q1_EX_DATE",ET."Q1_RATE",ET."Q1_ACCRUED_INCOME",ET."Q1_INCOME_CALCULATED",ET."Q1_TO_PAY",ET."Q1_NOTES",ET."Q2_EX_DATE",ET."Q2_RATE",ET."Q2_ACCRUED_INCOME",ET."Q2_INCOME_CALCULATED",ET."Q2_TO_PAY",ET."Q2_NOTES",ET."Q3_EX_DATE",ET."Q3_RATE",ET."Q3_ACCRUED_INCOME",ET."Q3_INCOME_CALCULATED",ET."Q3_TO_PAY",ET."Q3_NOTES",ET."Q4_EX_DATE",ET."Q4_RATE",ET."Q4_ACCRUED_INCOME",ET."Q4_INCOME_CALCULATED",ET."Q4_TO_PAY",ET."Q4_NOTES" FROM "CADIS"."VW_ANNUAL_MASTER_INCOME" ET WITH (NOLOCK)