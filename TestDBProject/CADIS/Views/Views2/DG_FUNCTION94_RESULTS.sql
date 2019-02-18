﻿CREATE VIEW "CADIS"."DG_FUNCTION94_RESULTS" AS 
SELECT ET."ControlLogFrequencyId",ET."FrequencyName",ET."DisplayOrder",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Audit"."ControlLogFrequency" ET WITH (NOLOCK)
