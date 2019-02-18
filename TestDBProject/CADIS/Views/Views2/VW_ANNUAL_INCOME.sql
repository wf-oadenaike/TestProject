﻿CREATE VIEW "CADIS"."VW_ANNUAL_INCOME"
AS


SELECT 
	[FUND_SHORT_NAME],
	[EDM_SEC_ID],
	[FUND_FISCAL_YEAR],
	MAX([SECURITY_NAME])		AS [SECURITY_NAME],
	MAX([DVD_CCY])			AS [DVD_CCY],
	MAX([WITHHOLDING_TAX])		AS [WITHHOLDING_TAX],
	MAX([DECLARED_DATE])		AS [DECLARED_DATE],
	MAX([POSITION_DATE])		AS [POSITION_DATE],
	MAX([POSITION])			AS [POSITION],
	MAX([BID_PRICE])		AS [BID_PRICE],
	MAX([SPOT_RATE])		AS [SPOT_RATE],
	MAX([MARKET_VALUE])		AS [MARKET_VALUE],
	MAX([D1])			AS [Q1_EX_DATE],
	MAX([R1])			AS [Q1_RATE],
	MAX([I1])			AS [Q1_NET_INCOME],
	MAX([P1])			AS [Q1_TO_PAY],
	MAX([N1])			AS [Q1_NOTES],
	MAX([D2])			AS [Q2_EX_DATE],
	MAX([R2])			AS [Q2_RATE],
	MAX([I2])			AS [Q2_NET_INCOME],
	MAX([P2])			AS [Q2_TO_PAY],
	MAX([N2])			AS [Q2_NOTES],
	MAX([D3])			AS [Q3_EX_DATE],
	MAX([R3])			AS [Q3_RATE],
	MAX([I3])			AS [Q3_NET_INCOME],
	MAX([P3])			AS [Q3_TO_PAY],
	MAX([N3])			AS [Q3_NOTES],
	MAX([D4])			AS [Q4_EX_DATE],
	MAX([R4])			AS [Q4_RATE],
	MAX([I4])			AS [Q4_NET_INCOME],
	MAX([P4])			AS [Q4_TO_PAY],
	MAX([N4])			AS [Q4_NOTES]
FROM (
	SELECT
		SEC.[SECURITY_NAME],
		INC.*,
		'D' + CAST(INC.[FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_EX_DATE],
		'R' + CAST(INC.[FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_RATE],
		'I' + CAST(INC.[FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_NET_INCOME],
		'P' + CAST(INC.[FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_TO_PAY],
		'N' + CAST(INC.[FUND_FISCAL_QUARTER] AS VARCHAR)	AS [QUARTER_NOTES]
	FROM "dbo"."T_MASTER_SEC_INCOME" AS INC
		INNER JOIN "dbo"."T_MASTER_SEC" SEC ON INC.[EDM_SEC_ID] = SEC.[EDM_SEC_ID]
) AS DVD
PIVOT (MAX([EX_DATE]) FOR [QUARTER_EX_DATE] IN ([D1],[D2],[D3],[D4])) AS DAT
PIVOT (MAX([RATE]) FOR [QUARTER_RATE] IN ([R1],[R2],[R3],[R4])) AS RAT
PIVOT (MAX([NET_INCOME]) FOR [QUARTER_NET_INCOME] IN ([I1],[I2],[I3],[I4])) AS INC
PIVOT (MAX([TO_PAY]) FOR [QUARTER_TO_PAY] IN ([P1],[P2],[P3],[P4])) AS PAY
PIVOT (MAX([NOTES]) FOR [QUARTER_NOTES] IN ([N1],[N2],[N3],[N4])) AS NTS
GROUP BY [FUND_SHORT_NAME],[EDM_SEC_ID],[FUND_FISCAL_YEAR]