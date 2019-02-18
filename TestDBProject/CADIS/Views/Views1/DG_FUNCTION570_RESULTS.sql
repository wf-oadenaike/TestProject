CREATE VIEW "CADIS"."DG_FUNCTION570_RESULTS" AS 
SELECT ET."OrderId",ET."EventDate",ET."Year",ET."Month",ET."OrderDate",ET."Security_Name",ET."Broker",ET."Country",ET."TotalValue",ET."Performance",ET."TCAException",ET."Benchmark",ET."ReasonCode",ET."slck_OrderID",ET."slck_Message",ET."slck_PostedBy" FROM "Access.WebDev"."BERCMonthlyReasonCodesUnquotedVw" ET WITH (NOLOCK)
