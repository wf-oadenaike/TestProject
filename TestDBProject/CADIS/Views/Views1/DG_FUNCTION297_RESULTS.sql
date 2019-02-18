﻿CREATE VIEW "CADIS"."DG_FUNCTION297_RESULTS" AS 
SELECT ET."LossOccurrenceEventId",ET."LossOccurrenceid",ET."EventDetails",ET."EventType",ET."EventDate",ET."IsActive",ET."SubmittedBy",ET."DocumentationFolderLink",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Access.ManyWho"."RiskLossOccurrenceEventsReadOnlyVw" ET WITH (NOLOCK)
