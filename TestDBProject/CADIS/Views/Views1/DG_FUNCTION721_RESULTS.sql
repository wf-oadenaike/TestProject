CREATE VIEW "CADIS"."DG_FUNCTION721_RESULTS" AS 
SELECT ET."ReviewID",ET."StatusID",ET."RequestID",ET."ReviewTypeID",ET."Details",ET."SubmittedDate",ET."ReviewerPersonID",ET."JiraIssueKey",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."NewOrgStructureReviewRegister" ET WITH (NOLOCK)
