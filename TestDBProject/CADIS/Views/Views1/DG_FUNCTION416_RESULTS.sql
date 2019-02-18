CREATE VIEW "CADIS"."DG_FUNCTION416_RESULTS" AS 
SELECT ET."WhistleblowingEventId",ET."WhistleblowingId",ET."WhistleblowingEventTypeId",ET."RecordedByPersonId",ET."EventDetails",ET."EventDate",ET."DocumentationFolderLink",ET."JoinGUID",ET."WhistleblowingEventCreationDate",ET."WhistleblowingEventLastModifiedDate" FROM "Organisation"."WhistleblowingEvents" ET WITH (NOLOCK)
