﻿CREATE VIEW "CADIS"."DG_FUNCTION441_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."VALUATION_DATE",ET."DESCRIPTION",ET."VALUE",ET."IsEstimate",ET."LastUpdatedDate" FROM "Access.WebDev"."ufn_GetAUMs"(NULL) ET