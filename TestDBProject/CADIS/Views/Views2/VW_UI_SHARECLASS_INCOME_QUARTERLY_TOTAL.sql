﻿CREATE VIEW "CADIS"."VW_UI_SHARECLASS_INCOME_QUARTERLY_TOTAL"
AS
SELECT
	[FUND_SHORT_NAME],
	[FUND_FISCAL_YEAR],
	SUM([UNITS_IN_ISSUE])	AS [UNITS_IN_ISSUE],
	SUM([FUND_VALUE])		AS [FUND_VALUE]
FROM "CADIS"."VW_UI_SHARECLASS_INCOME_QUARTERLY"
GROUP BY 
	[FUND_SHORT_NAME],
	[FUND_FISCAL_YEAR]
