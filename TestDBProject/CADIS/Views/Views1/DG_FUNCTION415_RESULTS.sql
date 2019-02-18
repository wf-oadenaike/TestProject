﻿CREATE VIEW "CADIS"."DG_FUNCTION415_RESULTS" AS 
SELECT ET."AnnualBudgetId",ET."DepartmentId",ET."BudgetOwnerPersonId",ET."FinancialYear",ET."BudgetSubmittedDate",ET."BudgetApproved",ET."BudgetStatus",ET."DiscrBudgetSummary",ET."DiscrEstimatedBudgetImpact",ET."DiscrBudgetImpactExceeds500K",ET."DiscrJIRAEpicKey",ET."DiscrReviewerComments",ET."NonDiscrBudgetSummary",ET."NonDiscrEstimatedBudgetImpact",ET."NonDiscrBudgetImpactExceeds500K",ET."NonDiscrJIRAEpicKey",ET."NonDiscrReviewerComments",ET."DocumentationFolderLink",ET."SubflowJoinURL",ET."JoinGUID",ET."AnnualBudgetCreationDatetime",ET."AnnualBudgetLastModifiedDatetime",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Organisation"."AnnualBudget" ET WITH (NOLOCK)
