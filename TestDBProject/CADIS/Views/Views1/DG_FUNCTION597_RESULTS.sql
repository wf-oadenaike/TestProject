CREATE VIEW "CADIS"."DG_FUNCTION597_RESULTS" AS 
SELECT ET."OrderIdFrom",ET."OrderIdTo",ET."Event",ET."OrderId",ET."Account",ET."Security",ET."Ticker",ET."Quantity",ET."Price",ET."Broker",ET."SlackCommentary",ET."Year",ET."Month" FROM "Access.WebDev"."AggregationPolicySplitAggregatedOrders" ET WITH (NOLOCK)
