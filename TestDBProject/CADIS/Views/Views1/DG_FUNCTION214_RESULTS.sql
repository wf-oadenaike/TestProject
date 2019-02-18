CREATE VIEW "CADIS"."DG_FUNCTION214_RESULTS" AS 
SELECT ET."DepartmentId",ET."BudgetOwnerPersonId",ET."DepartmentNumber",ET."DepartmentName",ET."PersonsName",ET."BoxFolderId",ET."BoxProjectFolderId",ET."BudgetOwnerCreationDate" FROM "Access.ManyWho"."AnnualBudgetOwnersVw" ET WITH (NOLOCK)
