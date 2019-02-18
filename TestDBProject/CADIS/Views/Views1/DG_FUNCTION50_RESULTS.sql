CREATE VIEW "CADIS"."DG_FUNCTION50_RESULTS" AS 
SELECT ET."MeetingOccurrenceId",ET."MeetingAgendaItemId",ET."MeetingOccurrenceCreationDatetime",ET."MeetingOccurrenceLastModifiedDatetime" FROM "Organisation"."MeetingOccurrenceJiraIssueCreationLog" ET WITH (NOLOCK)
