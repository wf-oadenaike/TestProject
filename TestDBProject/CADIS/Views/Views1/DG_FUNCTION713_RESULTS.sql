CREATE VIEW "CADIS"."DG_FUNCTION713_RESULTS" AS 
SELECT ET."RequestID",ET."SubmittedByPersonID",ET."StatusID",ET."EntityID",ET."EntityName",ET."JiraIssueKey",ET."Reason",ET."ChangeTypeID",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."NewOrgStructureChangeRequestRegister" ET WITH (NOLOCK)
