﻿CREATE VIEW "CADIS"."DG_FUNCTION630_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."OVERDRAFTDAYS120",ET."DAYSTILLBREACH120",ET."BREACHDATE120",ET."OVERDRAFTDAYS180",ET."DAYSTILLBREACH180",ET."BREACHDATE180",ET."OVERDRAFTDAYS360",ET."DAYSTILLBREACH360",ET."BREACHDATE360",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."ufn_GetOverdraftDaysAndProjectedBreachDates"() ET