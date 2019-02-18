﻿CREATE VIEW "CADIS"."DG_FUNCTION191_RESULTS" AS 
SELECT ET."EDM_SEC_ID",ET."PRICE_TYPE",ET."PRICE_DATE",ET."PRICE_SOURCE",ET."PRICE_TIME",ET."AVERAGE_COST",ET."PRICE_SOURCE_RANKING",ET."PRICE_ISO_CCY",ET."MASTER_PRICE",ET."ASK_PRICE",ET."MID_PRICE",ET."BID_PRICE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."LAST_UPDATE_DATE",ET."FX_RATE",ET."MARKET_VALUE",ET."TICKER",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_PRC" ET WITH (NOLOCK)
