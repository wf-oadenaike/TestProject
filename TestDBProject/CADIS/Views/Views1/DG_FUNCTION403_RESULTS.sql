CREATE VIEW "CADIS"."DG_FUNCTION403_RESULTS" AS 
SELECT ET."ConflictRegisterIdBK",ET."ConflictEventTypeId",ET."ConflictEventCreationDate",ET."ConflictsRegisterEventId",ET."EventDetails",ET."EventDate",ET."EventTrueFalse",ET."DocumentationFolderLink",ET."WorkflowVersionGUID",ET."JoinGUID",ET."ConflictEventLastModifiedDate" FROM "Compliance"."ConflictsRegisterEvents" ET WITH (NOLOCK)
