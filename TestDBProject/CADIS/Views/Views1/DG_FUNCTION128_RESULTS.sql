CREATE VIEW "CADIS"."DG_FUNCTION128_RESULTS" AS 
SELECT ET."CreatedMonth",ET."CreatedYearMonth",ET."CreatedMonthNum",ET."CreatedYear",ET."FormattedTotalAmount",ET."FormattedTotalVATAmount",ET."FormattedTotalGrossAmount" FROM "Access.ManyWho"."ClientBillingMonthlyTotalVw" ET WITH (NOLOCK)
