CREATE VIEW "CADIS"."DG_FUNCTION677_RESULTS" AS 
SELECT ET."EventID",ET."ChecklistID",ET."EventType",ET."ChecklistName",ET."EventDate",ET."SubmittedByPersonID",ET."SubmittedBy",ET."JiraIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."Compliance_KYCEventsReadOnlyVw" ET WITH (NOLOCK)
