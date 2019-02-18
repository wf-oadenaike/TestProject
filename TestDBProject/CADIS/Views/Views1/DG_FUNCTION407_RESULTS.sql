﻿CREATE VIEW "CADIS"."DG_FUNCTION407_RESULTS" AS 
SELECT ET."AuditPlanEventId",ET."AuditPlanRegisterId",ET."AuditPlanEventType",ET."EventPersonId",ET."EventRoleId",ET."EventTrueFalse",ET."EventDetails",ET."EventDate",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."AuditPlanEventCreationDate",ET."AuditPlanEventLastModifiedDate" FROM "Internal.Audit"."AuditPlanEvents" ET WITH (NOLOCK)