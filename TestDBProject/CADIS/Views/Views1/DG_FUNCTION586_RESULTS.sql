﻿CREATE VIEW "CADIS"."DG_FUNCTION586_RESULTS" AS 
SELECT ET."OrderID",ET."SecurityName",ET."Ticker",ET."OrderShares",ET."TotalValue",ET."Year",ET."Month",ET."SlackCommentary" FROM "Access.WebDev"."AggregationPolicySmallOrders" ET WITH (NOLOCK) WHERE (
"TOTALVALUE" 
	<= 
(SELECT INT_VALUE FROM "dbo"."T_REF_LOOKUP" WHERE ENTITY = 'WEB_DEV' AND SUB_ENTITY ='DEAGG_TOO_SMALL_TRADES' AND FIELD = 'F_QUANTITY' AND FIELD_VALUE = 'TOLERANCE')
)

