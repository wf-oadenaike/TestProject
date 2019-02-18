﻿CREATE VIEW "CADIS"."DG_FUNCTION653_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."INCOME_PERIOD_QTR",ET."INCOME_PERIOD_YR",ET."AS_AT_DATE",ET."GROSS_DVD_VAL",ET."GROSS_DVD_VAL_PREV",ET."GROSS_DVD_VAL_CHG",ET."NET_DVD_VAL",ET."NET_DVD_VAL_PREV",ET."NET_DVD_VAL_CHG",ET."UNITS",ET."UNITS_PREV",ET."UNITS_CHG",ET."GROSS_DVD_VAL_ORIG",ET."NET_DVD_VAL_ORIG",ET."UNITS_ORIG",ET."DVD_RATE",ET."DVD_RATE_PREV",ET."DVD_RATE_CHG",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."BPSDividendsQuarterlySummaryVw" ET WITH (NOLOCK)
