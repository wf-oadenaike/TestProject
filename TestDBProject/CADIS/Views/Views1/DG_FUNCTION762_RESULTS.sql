﻿CREATE VIEW "CADIS"."DG_FUNCTION762_RESULTS" AS 
SELECT ET."Sector",ET."PREFERRED_NAME",ET."EndWeight",ET."AS_AT_DATE" FROM "Access.WebSite"."ufn_GetFundSummaryByTop10Holdings"(NULL) ET
