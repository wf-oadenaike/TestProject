﻿CREATE VIEW "CADIS"."DG_FUNCTION166_RESULTS" AS 
SELECT ET."FinanceRequestEventId",ET."FinanceRequestId",ET."FinanceRequestEventType",ET."RecordedByPersonId",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."JoinGUID",ET."FinanceRequestEventCreationDatetime",ET."FinanceRequestEventLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."FinanceRequestEvents" ET WITH (NOLOCK)