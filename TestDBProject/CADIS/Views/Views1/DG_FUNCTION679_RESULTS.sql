CREATE VIEW "CADIS"."DG_FUNCTION679_RESULTS" AS 
SELECT ET."UBOControllersID",ET."Name",ET."ChecklistID",ET."ChecklistName",ET."PersonType",ET."Controller",ET."IsActive",ET."Details",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."Compliance_KYCUBOControllersReadOnlyVw" ET WITH (NOLOCK)
