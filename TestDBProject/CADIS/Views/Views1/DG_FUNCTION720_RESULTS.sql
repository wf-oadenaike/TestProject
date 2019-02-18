CREATE VIEW "CADIS"."DG_FUNCTION720_RESULTS" AS 
SELECT ET."ChangeID",ET."RequestID",ET."SubmittedByPersonID",ET."AccountabilityID",ET."CurrentValue",ET."ProposedValue",ET."ChangeTypeID",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "dbo"."NewOrgStructureChangesRegister" ET WITH (NOLOCK)
