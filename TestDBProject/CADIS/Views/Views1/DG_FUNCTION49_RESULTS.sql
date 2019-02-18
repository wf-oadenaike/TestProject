CREATE VIEW "CADIS"."DG_FUNCTION49_RESULTS" AS 
SELECT ET."MeetingRegisterId",ET."AttendeeRoleId",ET."ActiveFlag",ET."WorkflowVersionGUID",ET."JoinGUID",ET."MeetingAttendeeFromDatetime",ET."MeetingAttendeeToDatetime" FROM "Organisation"."MeetingAttendees" ET WITH (NOLOCK)
