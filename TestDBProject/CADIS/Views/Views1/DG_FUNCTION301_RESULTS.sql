﻿CREATE VIEW "CADIS"."DG_FUNCTION301_RESULTS" AS 
SELECT ET."TrailCommissionEventId",ET."TrailCommissionId",ET."EventDetails",ET."EventType",ET."Submitted By",ET."DocumentationFolderLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Access.ManyWho"."TrailCommissionEventsReadOnlyVw" ET WITH (NOLOCK)