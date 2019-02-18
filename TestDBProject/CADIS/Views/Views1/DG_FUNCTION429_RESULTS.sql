﻿CREATE VIEW "CADIS"."DG_FUNCTION429_RESULTS" AS 
SELECT ET."BudgetChangeId",ET."ResearchBrokerId",ET."PerformanceChange",ET."ResourceChange",ET."SectorChange",ET."BudgetChangeComments",ET."ChangeAmount",ET."BudgetAmendmentDate",ET."AmendedByPersonId",ET."AmendedBy",ET."DocumentationFolderLink",ET."JoinGUID",ET."BudgetChangeCreationDatetime",ET."BudgetChangeLastModifiedDatetime" FROM "Access.ManyWho"."ResearchBrokerBudgetChangesReadOnlyVw" ET WITH (NOLOCK)