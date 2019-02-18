CREATE VIEW "CADIS"."DG_FUNCTION36_RESULTS" AS 
SELECT ET."ConflictsRegisterActionId",ET."ConflictId",ET."ActionTypeId",ET."ActionDate",ET."ActionComment",ET."CreatedByPersonId",ET."CreationDate",ET."JIRAIssueKey",ET."IsActive",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Compliance"."ConflictsRegisterActions" ET WITH (NOLOCK)
