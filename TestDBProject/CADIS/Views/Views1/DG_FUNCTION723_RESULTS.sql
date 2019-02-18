CREATE VIEW "CADIS"."DG_FUNCTION723_RESULTS" AS 
SELECT ET."ChangeID",ET."RequestID",ET."SubmittedByPersonID",ET."SubmittedByPersonName",ET."CurrentValue",ET."ProposedValue",ET."ChangeTypeID",ET."ChangeTypeName",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."NewOrgStructureChangesRegisterVw" ET WITH (NOLOCK)
