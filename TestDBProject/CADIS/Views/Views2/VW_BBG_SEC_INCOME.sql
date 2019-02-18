﻿CREATE VIEW "CADIS"."VW_BBG_SEC_INCOME"
AS
SELECT
	[FUND_SHORT_NAME],
	[EDM_SEC_ID],
	[FUND_FISCAL_YEAR],
	CAST([POSITION_DATE] 
		AS DATETIME)	AS [POSITION_DATE],
	MAX([DVD_CCY])		AS [DVD_CCY],
	MAX([WITHHOLDING_TAX])	AS [WITHHOLDING_TAX],
	MAX([SPOT_RATE])	AS [SPOT_RATE],
	MAX([POSITION])		AS [POSITION],
	MAX([DECLARED_DATE])	AS [DECLARED_DATE],
	MAX([D1])		AS [Q1_EX_DATE],
	MAX([R1])		AS [Q1_RATE],
	MAX([I1])		AS [Q1_NET_INCOME],
	MAX([D2])		AS [Q2_EX_DATE],
	MAX([R2])		AS [Q2_RATE],
	MAX([I2])		AS [Q2_NET_INCOME],
	MAX([D3])		AS [Q3_EX_DATE],
	MAX([R3])		AS [Q3_RATE],
	MAX([I3])		AS [Q3_NET_INCOME],
	MAX([D4])		AS [Q4_EX_DATE],
	MAX([R4])		AS [Q4_RATE],
	MAX([I4])		AS [Q4_NET_INCOME]
FROM (
	SELECT
		DVD.[Position_LastDate]					AS [POSITION_DATE],
		FND.[SHORT_NAME]					AS [FUND_SHORT_NAME],
		DVD.[EDM_SEC_ID],
		DATEPART(YEAR,DATEADD(QUARTER,ISNULL(
			FND.[INCOME_PERIOD_QUARTER_OFFSET],0),
			DVD.[ExDate]))					AS [FUND_FISCAL_YEAR],
		DVD.[DvdCCY]						AS [DVD_CCY],
		DVD.[WithholdingTax]					AS [WITHHOLDING_TAX],
		DVD.[SpotRate]						AS [SPOT_RATE],
		DVD.[Quantity_LastDate]					AS [POSITION],
		HST.[DECLARED_DATE],
		DVD.[ExDate]						AS [EX_DATE],
		DVD.[DvdValue_ExDate]					AS [RATE],
		DVD.[NetDvdValue]					AS [NET_INCOME],
		'D' + CAST(DATEPART(QUARTER,DATEADD(QUARTER,ISNULL(
			FND.[INCOME_PERIOD_QUARTER_OFFSET],0),
			DVD.[ExDate])) AS VARCHAR)			AS [QUARTER_EX_DATE],
		'R' + CAST(DATEPART(QUARTER,DATEADD(QUARTER,ISNULL(
			FND.[INCOME_PERIOD_QUARTER_OFFSET],0),
			DVD.[ExDate])) AS VARCHAR)			AS [QUARTER_RATE],
		'I' + CAST(DATEPART(QUARTER,DATEADD(QUARTER,ISNULL(
			FND.[INCOME_PERIOD_QUARTER_OFFSET],0),
			DVD.[ExDate])) AS VARCHAR)			AS [QUARTER_NET_INCOME]
	FROM [Investment].[ufn_BBG_DVDs]() DVD
		INNER JOIN "dbo"."T_MASTER_FND" FND ON DVD.[FundShortName] = FND.[SHORT_NAME]
		LEFT JOIN "dbo"."T_BPS_DVD_HIST" HST ON DVD.[EDM_SEC_ID] = HST.[EDM_SEC_ID]
) AS UNP
PIVOT (MAX([EX_DATE]) FOR [QUARTER_EX_DATE] IN ([D1],[D2],[D3],[D4])) AS [EXD]
PIVOT (MAX([RATE]) FOR [QUARTER_RATE] IN ([R1],[R2],[R3],[R4])) AS [RAT]
PIVOT (MAX([NET_INCOME]) FOR [QUARTER_NET_INCOME] IN ([I1],[I2],[I3],[I4])) AS [INC]
GROUP BY [POSITION_DATE],[FUND_SHORT_NAME],[EDM_SEC_ID],[FUND_FISCAL_YEAR]
