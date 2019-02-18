﻿CREATE VIEW "CADIS"."DG_FUNCTION221_RESULTS" AS 
SELECT ET."KPIGroupName",ET."KPIGroupId",ET."KPIGroupDescription",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "KPI"."KPIGroups" ET WITH (NOLOCK)