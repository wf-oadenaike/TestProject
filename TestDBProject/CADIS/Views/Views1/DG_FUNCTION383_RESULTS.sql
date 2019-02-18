CREATE VIEW "CADIS"."DG_FUNCTION383_RESULTS" AS 
SELECT ET."PlacingEventId",ET."PlacingRegisterId",ET."PlacingEventType",ET."EventPersonId",ET."PersonSalesforceUserId",ET."PersonsName",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."JoinGUID",ET."PlacingEventCreationDatetime",ET."PlacingEventLastModifiedDatetime" FROM "Access.ManyWho"."PlacingEventsVw" ET WITH (NOLOCK)
