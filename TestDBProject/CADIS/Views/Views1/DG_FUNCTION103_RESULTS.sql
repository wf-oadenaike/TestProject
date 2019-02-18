﻿CREATE VIEW "CADIS"."DG_FUNCTION103_RESULTS" AS 
SELECT ET."UnquotedCompanyStage",ET."RoleId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."UnquotedCompanyStageRoles" ET WITH (NOLOCK)
