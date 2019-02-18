﻿CREATE VIEW "CADIS"."VW_NT_FND_INCOME"
AS
SELECT
	[FUND_SHORT_NAME],
	[VALUATION_DATE], 
	MAX([UNITS])		AS [UNITS],
	MAX([FUND_NET_INCOME])	AS [FUND_NET_INCOME],
	MAX([RATE])		AS [RATE]
FROM
(
	SELECT
		*
	FROM "CADIS"."DI_VANTEIARPT_STAGE_RSLT"
	WHERE [All Tests Passed?] = 1
) VAL
GROUP BY [FUND_SHORT_NAME],[VALUATION_DATE]