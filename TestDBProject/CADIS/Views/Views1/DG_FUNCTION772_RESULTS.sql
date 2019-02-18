﻿CREATE VIEW "CADIS"."DG_FUNCTION772_RESULTS" AS 
SELECT ET."SOURCE",ET."POSITION_TYPE",ET."EDM_SEC_ID",ET."FUND_SHORT_NAME",ET."LONG_SHORT_IND",ET."POSITION_DATE",ET."QUANTITY",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED" FROM "dbo"."T_MASTER_POS" ET WITH (NOLOCK)