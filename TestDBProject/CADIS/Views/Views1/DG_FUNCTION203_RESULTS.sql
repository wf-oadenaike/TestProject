﻿CREATE VIEW "CADIS"."DG_FUNCTION203_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."TRANSACTION_DATE",ET."CURRENCY",ET."FUND_FLOW_TYPE",ET."FLOW_TYPE",ET."SOURCE_TYPE",ET."SETTLEMENT_DATE",ET."MARKET_VALUE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED" FROM "dbo"."T_MASTER_GROSS_FUND_FLOW" ET WITH (NOLOCK)
