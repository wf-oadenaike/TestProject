﻿CREATE VIEW "CADIS"."DG_FUNCTION750_RESULTS" AS 
SELECT ET."FundShortName",ET."EDM_SEC_ID",ET."CalendarYear",ET."Q1ExDate",ET."Q1Rate",ET."Q2ExDate",ET."Q2Rate",ET."Q3ExDate",ET."Q3Rate",ET."Q4ExDate",ET."Q4Rate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_DIVIDEND_FORECAST" ET WITH (NOLOCK)