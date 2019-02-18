﻿CREATE VIEW "CADIS"."DG_FUNCTION604_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."TRANSACTION_DATE",ET."FLOW_TYPE",ET."RECOGNITION_DATE",ET."MARKET_VALUE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED" FROM "dbo"."V_SLA_MASTER_FND_FLOW_OMWEIF" ET WITH (NOLOCK)
