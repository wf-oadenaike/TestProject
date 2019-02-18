CREATE VIEW "CADIS"."DG_FUNCTION714_RESULTS" AS 
SELECT ET."EventID",ET."EventTypeID",ET."RequestID",ET."EventDetails",ET."EventDate",ET."SubmittedByPersonID",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."JiraIssueKey" FROM "dbo"."NewOrgStructureChangeRequestEvents" ET WITH (NOLOCK)
