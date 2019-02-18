CREATE VIEW "CADIS"."DG_FUNCTION637_RESULTS" AS 
SELECT ET."WatchlistEventId",ET."WatchlistRegisterId",ET."EventTypeid",ET."EventDetails",ET."SubmittedByPersonId",ET."EventDate",ET."EventTrueFalse",ET."JiraIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."Compliance_WatchListEvents" ET WITH (NOLOCK)
