CREATE VIEW "CADIS"."DG_FUNCTION117_RESULTS" AS 
SELECT ET."ClientBillingEventId",ET."ClientBillingId",ET."EventTypeId",ET."SubmittedByPersonId",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."JoinGUID",ET."ClientBillingEventCreationDate",ET."ClientBillingEventLastModifiedDatetime" FROM "Sales"."ClientBillingEvents" ET WITH (NOLOCK)
