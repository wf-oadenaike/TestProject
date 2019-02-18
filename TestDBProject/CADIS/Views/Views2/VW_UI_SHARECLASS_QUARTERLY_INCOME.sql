﻿CREATE VIEW "CADIS"."VW_UI_SHARECLASS_QUARTERLY_INCOME"
AS

WITH ShareClass AS 
(
	SELECT
		SCV.[VALUATION_DATE],
		F.[SHORT_NAME],
		SC.[SHARECLASS],				
		SCV.[UNITS_IN_ISSUE],
		SCV.[FUND_VALUE]
	FROM "dbo"."T_MASTER_SHARECLASS_VALUATION" SCV
		INNER JOIN "dbo"."T_MASTER_SHARECLASS" SC ON SCV.[EDM_SHARECLASS_ID] = SC.[EDM_SHARECLASS_ID]
		INNER JOIN "dbo"."T_MASTER_FND" F ON SC.[FUND_SHORT_NAME] = F.[SHORT_NAME]
),
FundQuarterly AS
(
	SELECT 
		[VALUATION_DATE],
		[FUND_SHORT_NAME],
		[FUND_FISCAL_YEAR],
		MAX([I1])		AS [Q1_NET_INCOME],
		MAX([I2])		AS [Q2_NET_INCOME],
		MAX([I3])		AS [Q3_NET_INCOME],
		MAX([I4])		AS [Q4_NET_INCOME]
	FROM (
		SELECT
			[VALUATION_DATE],
			[FUND_SHORT_NAME],
			[FUND_FISCAL_YEAR],
			[NET_INCOME],
			'I' + CAST([FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_NET_INCOME]
		FROM "CADIS"."VW_UI_FND_QUARTERLY_INCOME"
	) UNP
	PIVOT (MAX([NET_INCOME]) FOR [QUARTER_NET_INCOME] IN ([I1],[I2],[I3],[I4])) AS [INC]
	GROUP BY [VALUATION_DATE],[FUND_SHORT_NAME],[FUND_FISCAL_YEAR]
),
ShareClassQuarterlyNetIncome AS
(
	SELECT
		SC.*,
		FIQ.[FUND_FISCAL_YEAR],
		SC.[UNITS_IN_ISSUE]	AS [TOTAL_UNITS_IN_ISSUE],
		SC.[FUND_VALUE]		AS [TOTAL_FUND_VALUE],
		FIQ.[Q1_NET_INCOME] / SC.[FUND_VALUE] * SC.[FUND_VALUE]	AS [Q1_SHARE_CLASS_NET_INCOME],
		FIQ.[Q2_NET_INCOME] / SC.[FUND_VALUE] * SC.[FUND_VALUE]	AS [Q2_SHARE_CLASS_NET_INCOME],
		FIQ.[Q3_NET_INCOME] / SC.[FUND_VALUE] * SC.[FUND_VALUE]	AS [Q3_SHARE_CLASS_NET_INCOME],
		FIQ.[Q4_NET_INCOME] / SC.[FUND_VALUE] * SC.[FUND_VALUE]	AS [Q4_SHARE_CLASS_NET_INCOME]
	FROM ShareClass SC
		INNER JOIN FundQuarterly FIQ ON SC.[VALUATION_DATE] = FIQ.[VALUATION_DATE]
			AND SC.[SHORT_NAME] = FIQ.[FUND_SHORT_NAME]
)
SELECT 
	[VALUATION_DATE],
	[SHORT_NAME]						AS [FUND_SHORT_NAME],
	[SHARECLASS]						AS [SHARE_CLASS_NAME],
	[FUND_FISCAL_YEAR],
	[UNITS_IN_ISSUE],
	[FUND_VALUE],
	[Q1_SHARE_CLASS_NET_INCOME],
	[Q1_SHARE_CLASS_NET_INCOME] / [UNITS_IN_ISSUE]		AS [Q1_SHARE_CLASS_RATE],
	[Q2_SHARE_CLASS_NET_INCOME],
	[Q2_SHARE_CLASS_NET_INCOME] / [UNITS_IN_ISSUE]		AS [Q2_SHARE_CLASS_RATE],
	[Q3_SHARE_CLASS_NET_INCOME],
	[Q3_SHARE_CLASS_NET_INCOME] / [UNITS_IN_ISSUE]		AS [Q3_SHARE_CLASS_RATE],
	[Q4_SHARE_CLASS_NET_INCOME],
	[Q4_SHARE_CLASS_NET_INCOME] / [UNITS_IN_ISSUE]		AS [Q4_SHARE_CLASS_RATE]
FROM ShareClassQuarterlyNetIncome