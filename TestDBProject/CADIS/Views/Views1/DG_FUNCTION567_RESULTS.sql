CREATE VIEW "CADIS"."DG_FUNCTION567_RESULTS" AS 
SELECT ET."ConflictsRegisterMeetingID",ET."ConflictId",ET."MeetingDate",ET."MeetingOutcome",ET."CreatedByPersionId",ET."CreatedByPersonName",ET."CreationDate",ET."JIRAIssueKey" FROM "Access.ManyWho"."ConflictRegisterMeetingsVw" ET WITH (NOLOCK)
