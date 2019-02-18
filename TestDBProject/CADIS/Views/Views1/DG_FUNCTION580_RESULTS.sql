CREATE VIEW "CADIS"."DG_FUNCTION580_RESULTS" AS 
SELECT ET."OrderId",ET."ChildOrderId",ET."SecurityName",ET."Ticker",ET."OrderIdOrderShares",ET."ConstituentOrderId",ET."ConstituentOrderIdOrdershares",ET."PercentofConstituentOrdertoOrder",ET."SlackCommentary",ET."Year",ET."Month" FROM "Access.WebDev"."AggregationPolicyVolumeDifference" ET WITH (NOLOCK) WHERE (
"PercentofConstituentOrderToOrder" 
	<= 
(SELECT INT_VALUE FROM "dbo"."T_REF_LOOKUP" WHERE ENTITY = 'WEB_DEV' AND SUB_ENTITY ='DEAGG_PCT_TOLERANCE' AND FIELD = 'ORDERSHARES' AND FIELD_VALUE = 'TOLERANCE')
)

