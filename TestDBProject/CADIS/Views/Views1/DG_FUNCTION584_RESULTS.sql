CREATE VIEW "CADIS"."DG_FUNCTION584_RESULTS" AS 
SELECT ET."OrderID",ET."SecurityName",ET."Ticker",ET."Account",ET."SumOfTradeShares",ET."FQuantity",ET."TotalFQuantity",ET."Year",ET."Month",ET."SlackCommentary" FROM "Access.WebDev"."AggregationPolicyProrataAllocations" ET WITH (NOLOCK) WHERE (
"SumOfTradeShares" <> "FQuantity"  
)

