CREATE VIEW "CADIS"."DG_FUNCTION411_RESULTS" AS 
SELECT ET."ICAAPChangeEventId",ET."ICAAPChangeId",ET."ICAAPChangeEventTypeId",ET."RecordedByPersonId",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."JoinGUID",ET."ICAAPChangeEventCreationDatetime",ET."ICAAPChangeEventLastModifiedDatetime" FROM "Investment"."ICAAPChangeEvents" ET WITH (NOLOCK)
