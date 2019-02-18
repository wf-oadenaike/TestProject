
CREATE VIEW [Investment].[VW_Dividend_Forecast]
AS
SELECT
	P.[Fund Short Name],
	P.[EDM_SEC_ID],
	P.[Security Name],
	P.[Dvd CCY],
	P.[Position],
	P.[Price],
	P.[Mkt Value],
	P.[Dividend Declared],
	P.[Q1 XD Date],
	P.[Q1 Rate],
	P.[Q1 Income],
	CASE 
		WHEN P.[Q1 XD Date] > GETDATE() 
		THEN [Q1 Income] 
	END									AS [Q1 Yet To Go XD],
	P.[Q2 XD Date],
	P.[Q2 Rate],
	P.[Q2 Income],
	CASE 
		WHEN P.[Q2 XD Date] > GETDATE() 
		THEN [Q2 Income] 
	END									AS [Q2 Yet To Go XD],
	P.[Q3 XD Date],
	P.[Q3 Rate],
	P.[Q3 Income],
	CASE 
		WHEN P.[Q3 XD Date] > GETDATE() 
		THEN [Q3 Income] 
	END									AS [Q3 Yet To Go XD],
	P.[Q4 XD Date],
	P.[Q4 Rate],
	P.[Q4 Income],
	CASE 
		WHEN P.[Q4 XD Date] > GETDATE() 
		THEN [Q4 Income] 
	END									AS [Q4 Yet To Go XD]
FROM (
	SELECT 
		[FundShortName]							AS [Fund Short Name],
		[EDM_SEC_ID],
		[SecurityName]							AS [Security Name],
		MAX([DECLARED_DATE])						AS [Dividend Declared],
		MAX([DvdCCY])							AS [Dvd CCY],
		MAX([SpotRate])							AS [FX Rate],
		MAX([Withholding Tax Multiplier])				AS [Withholding Tax Multiplier],
		MAX([Quantity_LastDate])					AS [Position],
		MAX([Position_LastDate])					AS [Position Date],
		MAX([Price])							AS [Price],
		MAX([Quantity_LastDate]) * MAX([Price]) / 100			AS [Mkt Value],
		MAX([D1])							AS [Q1 XD Date],
		MAX([R1])							AS [Q1 Rate],
		MAX([Withholding Tax Multiplier]) * 
			MAX([Quantity_LastDate]) * MAX([R1]) /
			CASE 
				WHEN binary_checksum(MAX([DvdCCY])) = 
					binary_checksum('GBp')
				THEN 100
				ELSE MAX([SpotRate])
			END							AS [Q1 Income],
		MAX([D2])							AS [Q2 XD Date],
		MAX([R2])							AS [Q2 Rate],
		MAX([Withholding Tax Multiplier]) *
			MAX([Quantity_LastDate]) * MAX([R2]) /
			CASE 
				WHEN binary_checksum(MAX([DvdCCY])) = 
					binary_checksum('GBp')
				THEN 100
				ELSE MAX([SpotRate])
			END							AS [Q2 Income],
		MAX([D3])							AS [Q3 XD Date],
		MAX([R3])							AS [Q3 Rate],
		MAX([Withholding Tax Multiplier]) *
			MAX([Quantity_LastDate]) * MAX([R3]) /
			CASE 
				WHEN binary_checksum(MAX([DvdCCY])) = 
					binary_checksum('GBp')
				THEN 100
				ELSE MAX([SpotRate])
			END							AS [Q3 Income],
		MAX([D4])							AS [Q4 XD Date],
		MAX([R4])							AS [Q4 Rate],
		MAX([Withholding Tax Multiplier]) *
			MAX([Quantity_LastDate]) * MAX([R4]) /
			CASE 
				WHEN binary_checksum(MAX([DvdCCY])) = 
					binary_checksum('GBp')
				THEN 100
				ELSE MAX([SpotRate])
			END							AS [Q4 Income]
	FROM (
		SELECT
			UP.*,
			'D' + CAST(UP.[Qtr Adj] AS VARCHAR)			AS [Qtr D],
			'R' + CAST(UP.[Qtr Adj] AS VARCHAR)			AS [Qtr R]
		FROM
		(
			SELECT 
				[FundShortName],
				DVD.[EDM_SEC_ID],
				[SecurityName],
				[DvdCCY],
				[SpotRate],
				1 - [WithholdingTax]				AS [Withholding Tax Multiplier],
				[Quantity_LastDate],
				[Position_LastDate],
				T2.[BID_PRICE]			AS [Price],
				CASE 
					WHEN MONTH([ExDate]) + T1.[INCOME_PERIOD_QUARTER_OFFSET] IN (1,2,3)
					THEN 1
					WHEN MONTH([ExDate]) + T1.[INCOME_PERIOD_QUARTER_OFFSET] IN (4,5,6)
					THEN 2
					WHEN MONTH([ExDate]) + T1.[INCOME_PERIOD_QUARTER_OFFSET] IN (7,8,9)
					THEN 3
					WHEN MONTH([ExDate]) + T1.[INCOME_PERIOD_QUARTER_OFFSET] IN (10,11,12)
					THEN 4
				END						AS [Qtr Adj],
				[DvdValue_ExDate],
				[ExDate],
				T3.[DECLARED_DATE]
			FROM [Investment].[ufn_BBG_DVDs]() DVD
				INNER JOIN "dbo"."T_MASTER_FND" T1 ON DVD.[FundShortName] = T1.[SHORT_NAME]
				INNER JOIN "dbo"."T_MASTER_PRC" T2 ON DVD.[EDM_SEC_ID] = T2.[EDM_SEC_ID]
					AND DVD.[Position_LastDate] = T2.[PRICE_DATE]
					AND T2.[PRICE_TYPE] = 'EOD'
				LEFT JOIN "dbo"."T_BPS_DVD_HIST" T3 ON DVD.[EDM_SEC_ID] = T3.[EDM_SEC_ID]
			WHERE [Yr] = YEAR(DATEADD(YY,1,GETDATE()))
		) AS UP
	) AS DVD
	PIVOT (MAX([ExDate]) FOR [Qtr D] IN ([D1],[D2],[D3],[D4])) AS DAT
	PIVOT (MAX([DvdValue_ExDate]) FOR [Qtr R] IN ([R1],[R2],[R3],[R4])) AS RAT
	GROUP BY [FundShortName],[EDM_SEC_ID],[SecurityName]
) AS P
-- ORDER BY P.[Security Name],P.[Fund Short Name]

