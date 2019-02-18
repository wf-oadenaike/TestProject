CREATE VIEW "CADIS"."DG_FUNCTION523_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."ReasonCode",ET."ReasonCodeDescriptive",ET."NumberOfOrders" FROM "Access.WebDev"."BERCMonthlyReasonCodesSummaryVw" ET WITH (NOLOCK)
