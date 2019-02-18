CREATE VIEW "CADIS"."DG_FUNCTION60_RESULTS" AS 
SELECT ET."DepartmentId",ET."DepartmentName",ET."DepartmentNumber",ET."ControlId",ET."ActiveFlag",ET."ActiveFlagDateTime",ET."DepartmentSrcId",ET."SourceSystemId",ET."BAUJiraKey",ET."ProjectJiraKey",ET."DepartmentCreationDatetime",ET."DepartmentLastModifiedDatetime" FROM "Access.ManyWho"."DepartmentsVw" ET WITH (NOLOCK)
