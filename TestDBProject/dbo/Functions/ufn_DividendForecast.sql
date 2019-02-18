
CREATE FUNCTION [dbo].[ufn_DividendForecast]()
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[ufn_DividendForecast]
-- 
-- Params: 
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- S.Burns: 07/12/2018 JIRA: DAP-1955 Create function for quarterly Dividend Forecasts
--
-------------------------------------------------------------------------------------- 
RETURNS TABLE
AS
RETURN

SELECT PIV.* FROM 
(
	SELECT 
		[FundShortName],
		[EDM_SEC_ID],
		[Yr]									AS [CalendarYear],
		MAX([SecurityName])						AS [SecurityName],		
		MAX([DECLARED_DATE])					AS [DeclaredDate],
		MAX([DvdCCY])							AS [DvdCCY],
		MAX([SpotRate])							AS [SpotRate],
		MAX([Quantity_LastDate])				AS [Position],
		MAX([Position_LastDate])				AS [PositionDate],
		MAX([BID_PRICE])						AS [BidPrice],
		MAX([WithholdingTax])					AS [WithholdingTax],
		MAX([D1])								AS [Q1ExDate],
		MAX([R1])								AS [Q1Rate],
		MAX([D2])								AS [Q2ExDate],
		MAX([R2])								AS [Q2Rate],
		MAX([D3])								AS [Q3ExDate],
		MAX([R3])								AS [Q3Rate],
		MAX([D4])								AS [Q4ExDate],
		MAX([R4])								AS [Q4Rate]
	FROM (
		SELECT
			UNP.*,
			'D' + CAST(UNP.[QtrAdj] AS VARCHAR)	AS [QtrDate],
			'R' + CAST(UNP.[QtrAdj] AS VARCHAR)	AS [QtrRate]
		FROM
		(
			SELECT 
				DVD.[FundShortName],
				DVD.[EDM_SEC_ID],
				DVD.[SecurityName],
				DVD.[DvdCCY],
				DVD.[SpotRate],
				DVD.[WithholdingTax],
				DVD.[Quantity_LastDate],
				DVD.[Position_LastDate],
				PRC.[BID_PRICE],
				CASE 
					WHEN MONTH(DVD.[ExDate]) + 
						FND.[INCOME_PERIOD_QUARTER_OFFSET] IN (1,2,3)
					THEN 1
					WHEN MONTH(DVD.[ExDate]) + 
						FND.[INCOME_PERIOD_QUARTER_OFFSET] IN (4,5,6)
					THEN 2
					WHEN MONTH(DVD.[ExDate]) + 
						FND.[INCOME_PERIOD_QUARTER_OFFSET] IN (7,8,9)
					THEN 3
					WHEN MONTH(DVD.[ExDate]) + 
						FND.[INCOME_PERIOD_QUARTER_OFFSET] IN (10,11,12)
					THEN 4
				END								AS [QtrAdj],
				DVD.[DvdValue_ExDate],
				DVD.[ExDate],
				HST.[DECLARED_DATE],
				DVD.[Yr]
			FROM [Investment].[ufn_BBG_DVDs]() DVD
				INNER JOIN "dbo"."T_MASTER_FND" FND ON DVD.[FundShortName] = FND.[SHORT_NAME]
				INNER JOIN "dbo"."T_MASTER_PRC" PRC ON DVD.[EDM_SEC_ID] = PRC.[EDM_SEC_ID]
					AND DVD.[Position_LastDate] = PRC.[PRICE_DATE]
					AND PRC.[PRICE_TYPE] = 'EOD'
				LEFT JOIN "dbo"."T_BPS_DVD_HIST" HST ON DVD.[EDM_SEC_ID] = HST.[EDM_SEC_ID]
			WHERE [Yr] = YEAR(DATEADD(YY,1,GETDATE()))
		) AS UNP
	) AS DVD
	PIVOT (MAX([ExDate]) FOR [QtrDate] IN ([D1],[D2],[D3],[D4])) AS DAT
	PIVOT (MAX([DvdValue_ExDate]) FOR [QtrRate] IN ([R1],[R2],[R3],[R4])) AS RAT
	GROUP BY [FundShortName],[EDM_SEC_ID],[Yr]
) AS PIV

