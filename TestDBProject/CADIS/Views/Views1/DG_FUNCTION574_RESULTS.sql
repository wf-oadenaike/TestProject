﻿CREATE VIEW "CADIS"."DG_FUNCTION574_RESULTS" AS 
SELECT ET."ID",ET."ICBID",ET."Name",ET."FundManagerID",ET."InvestmentAnalystID" FROM "Investment"."T_REF_ICBIndustries" ET WITH (NOLOCK)