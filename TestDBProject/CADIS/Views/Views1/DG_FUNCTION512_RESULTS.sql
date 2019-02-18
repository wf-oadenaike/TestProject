CREATE VIEW "CADIS"."DG_FUNCTION512_RESULTS" AS 
SELECT ET."QuarterId",ET."QuarterEndingName",ET."TotalQuarterBudget",ET."TotalQuarterInvoicedAmount",ET."TotalQuarterPaidAmount" FROM "Access.ManyWho"."ResearchBrokerPaymentQuarterSumReadOnlyVw" ET WITH (NOLOCK)
