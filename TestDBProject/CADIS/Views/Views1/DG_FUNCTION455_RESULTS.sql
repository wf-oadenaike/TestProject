﻿CREATE VIEW "CADIS"."DG_FUNCTION455_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."EDM_SEC_ID",ET."SECURITY_NAME",ET."TICKER",ET."EX_DATE",ET."PrevDvdValue",ET."NewDvdValue",ET."ChangeDvdValue",ET."ChangeAmount",ET."DIVIDEND_CCY",ET."LastUpdatedDate" FROM "Access.WebDev"."DvdRateChangeVw" ET WITH (NOLOCK)
