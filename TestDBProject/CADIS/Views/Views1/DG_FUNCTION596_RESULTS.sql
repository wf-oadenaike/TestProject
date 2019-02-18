CREATE VIEW "CADIS"."DG_FUNCTION596_RESULTS" AS 
SELECT ET."OrderId",ET."SecurityName",ET."TradeExecutionSequenceNumber",ET."Ticker",ET."FillAmount",ET."TradeExecutionDate",ET."TradeExecutionTime",ET."TradeExecutionBroker",ET."Year",ET."Month" FROM "Access.WebDev"."AggregationPolicyFillsWithoutTimestamps" ET WITH (NOLOCK)
