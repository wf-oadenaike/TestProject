CREATE VIEW "CADIS"."DG_FUNCTION432_RESULTS" AS 
SELECT ET."CurrentFiscalYearBudget",ET."CurrentFiscalYearBudgetChanges",ET."CurrentQuarterBudget",ET."PreviousQuarterBudget",ET."CurrentQuarterBudgetChanges",ET."PreviousQuarterBudgetChanges" FROM "Access.ManyWho"."ResearchBrokerTotalBudgetExtractVw" ET WITH (NOLOCK)
