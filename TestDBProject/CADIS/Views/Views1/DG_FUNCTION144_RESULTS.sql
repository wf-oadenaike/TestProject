﻿CREATE VIEW "CADIS"."DG_FUNCTION144_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."POSITION_DATE",ET."ASSET_SUB_CATEGORY",ET."CCY",ET."LOCAL_VALUE",ET."BASE_VALUE",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_OVERRIDE_POS_ACCOUNT_BALANCE" ET WITH (NOLOCK)
