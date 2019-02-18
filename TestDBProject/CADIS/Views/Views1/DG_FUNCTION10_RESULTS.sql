CREATE VIEW "CADIS"."DG_FUNCTION10_RESULTS" AS 
SELECT ET."EBIRegisterId",ET."EBIEventTypeId",ET."EBIEventCreationDatetime",ET."EBIRegisterEventId",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."RecordedByPersonId",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."EBIEventLastModifiedDatetime" FROM "Compliance"."EBIRegisterEvents" ET WITH (NOLOCK)
