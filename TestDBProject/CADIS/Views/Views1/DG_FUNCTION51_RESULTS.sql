CREATE VIEW "CADIS"."DG_FUNCTION51_RESULTS" AS 
SELECT ET."MeetingOccurrenceId",ET."MeetingRegisterId",ET."MeetingDateTime",ET."MeetingNotes",ET."JIRAEpicKey",ET."ActiveFlag",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."MeetingOccurrenceCreationDatetime",ET."MeetingOccurrenceLastModifiedDatetime" FROM "Organisation"."MeetingOccurrence" ET WITH (NOLOCK)
