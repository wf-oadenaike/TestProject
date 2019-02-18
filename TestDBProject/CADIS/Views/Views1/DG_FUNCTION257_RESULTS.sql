CREATE VIEW "CADIS"."DG_FUNCTION257_RESULTS" AS 
SELECT ET."AccName",ET."AccPostcode",ET."AccFcaId",ET."AccOwnerName",ET."AccOwnerId",ET."AccSalesforceId",ET."MktShareDelta",ET."UKEquityIncomeMarketSales",ET."UKAllCompaniesMarketSales" FROM "Contacts"."SuggestedPriorityClientVw" ET WITH (NOLOCK)
