CREATE VIEW "CADIS"."DG_FUNCTION560_RESULTS" AS 
SELECT ET."RequestEventID",ET."ClientRequestID",ET."EventType",ET."ReviewerID",ET."SubmittedByPersonID",ET."EventDetails",ET."EventDate",ET."EventStatus",ET."JiraIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."EventTrueFalse" FROM "Sales"."DueDiligenceRequestEvents" ET WITH (NOLOCK)
