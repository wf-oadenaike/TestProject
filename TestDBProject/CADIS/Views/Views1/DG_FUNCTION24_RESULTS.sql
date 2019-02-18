CREATE VIEW "CADIS"."DG_FUNCTION24_RESULTS" AS 
SELECT ET."ConflictsRegisterMeetingID",ET."ConflictId",ET."MeetingDate",ET."MeetingOutcome",ET."CreatedByPersionId",ET."CreationDate",ET."JIRAIssueKey" FROM "Compliance"."ConflictsRegisterMeetings" ET WITH (NOLOCK)
