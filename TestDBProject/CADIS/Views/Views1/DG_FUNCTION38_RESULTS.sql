﻿CREATE VIEW "CADIS"."DG_FUNCTION38_RESULTS" AS 
SELECT ET."KPIId",ET."KPIGroupId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "KPI"."KPIGroupRelationship" ET WITH (NOLOCK)
