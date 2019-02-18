CREATE VIEW "CADIS"."DG_FUNCTION585_RESULTS" AS 
SELECT ET."ToolId",ET."ToolName",ET."ToolPurpose",ET."ToolOwnerId",ET."ToolOwnerName",ET."DepartmentName",ET."StatusId",ET."StatusName",ET."LastReviewDate",ET."NextReviewDate",ET."TargetRetirementDate",ET."IncludedInBIAAssessment",ET."JoinGUID",ET."JiraIssueKey" FROM "Access.ManyWho"."CriticalUserDefinedToolsRegisterReadOnlyVw" ET WITH (NOLOCK)
