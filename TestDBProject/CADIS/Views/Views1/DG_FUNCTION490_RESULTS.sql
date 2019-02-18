﻿CREATE VIEW "CADIS"."DG_FUNCTION490_RESULTS" AS 
SELECT ET."DVD_Overrides_ID",ET."EDM_SEC_ID",ET."BBG_EX_DATE",ET."OVERRIDE_EX_DATE",ET."OVERRIDE_DVD_VALUE",ET."OVERRIDE_COMMENTARY",ET."OVERRIDE_REASON",ET."IsActive",ET."LAST_UPDATED_BY",ET."LAST_UPDATED",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Investment"."DVD_Overrides" ET WITH (NOLOCK)
