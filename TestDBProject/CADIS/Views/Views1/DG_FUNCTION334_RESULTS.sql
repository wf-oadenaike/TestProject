﻿CREATE VIEW "CADIS"."DG_FUNCTION334_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."OverdraftDays",ET."POSITION_DATE" FROM "Access.WebDev"."ufn_GetOverdraftDaysCount"(NULL) ET
