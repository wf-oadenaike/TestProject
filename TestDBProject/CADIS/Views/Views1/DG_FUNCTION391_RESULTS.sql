﻿CREATE VIEW "CADIS"."DG_FUNCTION391_RESULTS" AS 
SELECT ET."BCPCriticalProcessEventId",ET."BCPCriticalProcessId",ET."RecordedByPersonId",ET."EventDetails",ET."EventType",ET."EventDate",ET."Status",ET."TechnologyDetails",ET."ProcessPersonId",ET."Supplier",ET."DocumentationFolderLink",ET."JoinGUID",ET."BCPCriticalProcessEventCreationDate",ET."BCPCriticalProcessEventLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "BAU"."BCPCriticalProcessEvents" ET WITH (NOLOCK)
