CREATE VIEW "CADIS"."DG_FUNCTION581_RESULTS" AS 
SELECT ET."OrderId",ET."ChildOrderId",ET."SecurityName",ET."Ticker",ET."OrderShares",ET."ReasonCode",ET."Year",ET."Month",ET."SlackCommentary" FROM "Access.WebDev"."AggregationPolicyContingentOrders" ET WITH (NOLOCK)
