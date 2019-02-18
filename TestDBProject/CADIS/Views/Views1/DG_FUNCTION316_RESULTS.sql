CREATE VIEW "CADIS"."DG_FUNCTION316_RESULTS" AS 
SELECT ET."FinPromEventId",ET."FinPromRegisterId",ET."FinPromEventType",ET."EventPersonId",ET."PersonsName",ET."EventRoleId",ET."EventTrueFalse",ET."EventComments",ET."EventDate",ET."WorkflowVersionGUID",ET."JoinGUID",ET."FinPromEventCreationDate",ET."FinPromEventLastModifiedDate" FROM "Access.ManyWho"."FinPromEventsReadOnlyVw" ET WITH (NOLOCK)
