﻿CREATE VIEW "CADIS"."DG_FUNCTION579_RESULTS" AS 
SELECT ET."ToolId",ET."ToolName",ET."ToolPurpose",ET."ToolOwnerId",ET."StatusId",ET."LastReviewDate",ET."NextReviewDate",ET."TargetRetirementDate",ET."ToolLink",ET."IncludedInBIAAssessment",ET."JIRAIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Organisation"."CriticalUserDefinedToolsRegister" ET WITH (NOLOCK)