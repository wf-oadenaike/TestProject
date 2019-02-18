﻿CREATE VIEW "CADIS"."DG_FUNCTION242_RESULTS" AS 
SELECT ET."FinPromEventId",ET."FinPromRegisterId",ET."FinPromEventType",ET."EventPersonId",ET."EventRoleId",ET."EventTrueFalse",ET."EventComments",ET."EventDate",ET."WorkflowVersionGUID",ET."JoinGUID",ET."FinPromEventCreationDate",ET."FinPromEventLastModifiedDate",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Investment"."FinPromEvents" ET WITH (NOLOCK)