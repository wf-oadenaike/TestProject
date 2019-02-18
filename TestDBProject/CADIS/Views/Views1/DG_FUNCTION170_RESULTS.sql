CREATE VIEW "CADIS"."DG_FUNCTION170_RESULTS" AS 
SELECT ET."NominalCode",ET."AccountName",ET."AccountCategoryId",ET."AccountCategory" FROM "Access.ManyWho"."FinanceAccountsVw" ET WITH (NOLOCK)
