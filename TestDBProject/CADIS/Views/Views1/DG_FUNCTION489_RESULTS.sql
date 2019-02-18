﻿CREATE VIEW "CADIS"."DG_FUNCTION489_RESULTS" AS 
SELECT ET."DVD_Fund_Overrides_ID",ET."FUND_SHORT_NAME",ET."OVERRIDE_DATE",ET."OVERRIDE_UNITS",ET."OVERRIDE_GROSS_DVD_VALUE",ET."OVERRIDE_NET_DVD_VALUE",ET."OVERRIDE_COMMENTARY",ET."OVERRIDE_REASON",ET."IsActive",ET."Qtr",ET."Yr",ET."LAST_UPDATED_BY",ET."LAST_UPDATED",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Investment"."DVD_Fund_Overrides" ET WITH (NOLOCK)
