CREATE VIEW "CADIS"."VW_Master_Dividend_Forecast"
AS
SELECT
	T1.*,
	T2.[Q1ExDate] AS [SourceQ1ExDate],
	T2.[Q1Rate] 	AS [SourceQ1Rate],
	T2.[Q2ExDate] AS [SourceQ2ExDate],
	T2.[Q2Rate] 	AS [SourceQ2Rate],
	T2.[Q3ExDate] AS [SourceQ3ExDate],
	T2.[Q3Rate] 	AS [SourceQ3Rate],
	T2.[Q4ExDate] AS [SourceQ4ExDate],
	T2.[Q4Rate] 	AS [SourceQ4Rate]
FROM "dbo"."T_MASTER_DIVIDEND_FORECAST" T1
	INNER JOIN "dbo"."T_PRE_DIVIDEND_FORECAST" T2 
	ON T1.[FundShortName] = T2.[FundShortName]
	AND T1.[EDM_SEC_ID] = T2.[EDM_SEC_ID] 
	AND T1.[CalendarYear] = T2.[CalendarYear] 
