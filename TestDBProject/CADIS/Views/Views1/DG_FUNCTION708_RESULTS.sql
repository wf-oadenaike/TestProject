CREATE VIEW "CADIS"."DG_FUNCTION708_RESULTS" AS 
SELECT ET."EventId",ET."HuddleEventId",ET."EventTypeId",ET."SubmittedByPersonId",ET."EventDate",ET."EventDetails",ET."JiraIssueKey",ET."JoinGUID",ET."IsActive",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Organisation"."HuddleRegisterEvents" ET WITH (NOLOCK)
