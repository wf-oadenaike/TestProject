CREATE VIEW "CADIS"."DG_FUNCTION542_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."OrderId",ET."Broker",ET."Security_Name",ET."Country",ET."TotalValue",ET."Performance",ET."TCAException",ET."Benchmark",ET."Slackcommentary",ET."ReasonCode",ET."ReasonCodeDescriptive",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."BERCLastMonthReasonCodesVw" ET WITH (NOLOCK)
