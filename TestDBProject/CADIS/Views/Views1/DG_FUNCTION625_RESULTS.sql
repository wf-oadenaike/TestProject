﻿CREATE VIEW "CADIS"."DG_FUNCTION625_RESULTS" AS 
SELECT ET."StopListReasonId",ET."StopListId",ET."StoppedCompanyName",ET."ReasonName",ET."StopListStatusName",ET."ReasonTypeId",ET."StopListStatusId",ET."ReasonOwner",ET."Requester",ET."Reviewer",ET."InteractionId",ET."ComplianceJiraIssueKey",ET."JIRAIssueKey",ET."StoppedDate",ET."AnticipatedCleanseDate",ET."AdvisedDate",ET."CleansedDate",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."StopListReasonRegisterReadOnlyVw" ET WITH (NOLOCK)
