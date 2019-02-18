CREATE VIEW "CADIS"."DG_FUNCTION686_RESULTS" AS 
SELECT ET."PermanentInsiderID",ET."FullName",ET."Email",ET."DepartmentName",ET."AssignedRoleName",ET."AdditionDateTime",ET."CeasedDateTime",ET."IsActive",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Access.ManyWho"."Compliance_PermanentInsidersReadOnlyVw" ET WITH (NOLOCK)
