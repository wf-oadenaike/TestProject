CREATE VIEW "CADIS"."DG_FUNCTION543_RESULTS" AS 
SELECT ET."OrderId",ET."Security_Name",ET."Broker",ET."Country",ET."TotalValue",ET."PerformanceBPS",ET."TCAException",ET."Benchmark",ET."Slackcommentary",ET."ReasonCode",ET."ReasonCodeDescriptive",ET."BenchmarkTotal",ET."PL" FROM "Access.WebDev"."BERCMostSignificantTrades_Vw" ET WITH (NOLOCK)
