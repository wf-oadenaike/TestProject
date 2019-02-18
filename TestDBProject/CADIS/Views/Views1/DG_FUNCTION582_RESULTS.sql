CREATE VIEW "CADIS"."DG_FUNCTION582_RESULTS" AS 
SELECT ET."OrderId",ET."ChildOrderId",ET."SecurityName",ET."Ticker",ET."OrderShares",ET."ReasonCode",ET."Year",ET."Month",ET."SlackCommentary",ET."CountOfRCPerChildOrder" FROM "Access.WebDev"."AggregationPolicyTradeInstructions" ET WITH (NOLOCK)
