﻿CREATE VIEW "CADIS"."DG_FUNCTION663_RESULTS" AS 
SELECT ET."CITI_CODE",ET."SECTOR",ET."PRICE_DATE",ET."FILE_DATE",ET."UNIT_NAME",ET."M1_PERFORMANCE",ET."M1_RANK",ET."M1_QUARTILE",ET."Y1_PERFORMANCE",ET."Y1_RANK",ET."Y1_QUARTILE",ET."YTD_PERFORMANCE",ET."YTD_RANK",ET."YTD_QUARTILE",ET."Y3_PERFORMANCE",ET."Y3_RANK",ET."Y3_QUARTILE",ET."D20140616_PERFORMANCE",ET."D20140616_RANK",ET."D20140616_QUARTILE",ET."D20170412_PERFORMANCE",ET."D20170412_RANK",ET."D20170412_QUARTILE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.WebDev"."FEFundPerformanceBySectorVw" ET WITH (NOLOCK)
