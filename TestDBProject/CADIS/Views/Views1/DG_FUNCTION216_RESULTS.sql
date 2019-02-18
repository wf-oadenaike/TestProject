CREATE VIEW "CADIS"."DG_FUNCTION216_RESULTS" AS 
SELECT ET."MeetingRegisterId",ET."MeetingNameBK",ET."AttendeeRoleId",ET."AttendeeRoleName",ET."AttendeePersonId",ET."AttendeeName",ET."AttendeeSalesforceUserId",ET."WorkflowVersionGUID",ET."JoinGUID" FROM "Access.ManyWho"."MeetingAttendeesVw" ET WITH (NOLOCK)
