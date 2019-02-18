CREATE FUNCTION [Access.WebDev].[ufn_CashLadderSummary]
(
    @TDate	DATE ,
	@Fund	VARCHAR(10) = NULL,
	@MaxDate	DATE
)
RETURNS TABLE
AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_CashLadderSummary]
-- 
-- Params:	@TDate DATE - Trade date for which the function is to be run for.
--			@Fund varchar(10) - Fund to filter data set on
-------------------------------------------------------------------------------------- 
-- History:
-- D.Fanning: 31/07/2017 JIRA: DAP-1032 - Extract T-1 to T+3 cash ladder data
-- D. Bacchus: 01/08/2017 - Optimised to run quicker in Data Generator
-- D. Bacchus: 25/09/2017 JIRA: DAP-1382 added group by to second part union query to create a distinct list, also changed TOP 3 to TOP 5
-- R. Dixon: 21/11/2017 DAP-1484 rewritten to use T_BBG_CASH_LADDER table as part of re-write of BBG cash ladder load
-- R. Dixon: 19/12/2017 DAP-1484 gets last working day's prior to current date for As Of Date
-- R. Dixon: 24/01/2018 DAP-1665 removes dependency on data from latest file load
-- R. Dixon: 08/02/2018 DAP-1665 performance tuned by Markit DBA.
-- R. Dixon: 08/02/2018 DAP-1648 added MaxDate parameter
-- R. Dixon: 29/03/2018 DAP-1898 return data between T-1 and T+5 business days
-- R. Dixon: 14/06/2018 DAP-1966 Include cash overrides for fund.
-------------------------------------------------------------------------------------- 

return (
		SELECT	DISTINCT
					[REPORT_DATE] as ReportDate,
					[FUND_SHORT_NAME] as Fund,
					[CCY],
					[AS_OF_DATE] AsOfDate,
					cast([VALUE] as decimal(18,2)) as Value,
					ValueGBP = cast([Value] / ISNULL(fx.[SPOT_RATE], 1)as decimal(18,2)),
					cast(fx.[SPOT_RATE] as decimal (18,6))as FxSpotRate,
					cast(0 as bit) AS [OVERRIDE]
			FROM	[dbo].[T_BBG_CASH_LADDER] C
			LEFT	OUTER JOIN [dbo].[T_MASTER_FXRATE] fx	
			ON		CONVERT(DATE,fx.DATE) = (SELECT MAX(CONVERT(DATE,DATE)) FROM [dbo].[T_MASTER_FXRATE]) 
			AND		fx.[FROM_ISO_CURRENCY_CODE] = 'GBP'
			AND		fx.[TO_ISO_CURRENCY_CODE] = C.CCY
			WHERE	C.AS_OF_DATE IN 
					(
					SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					UNION
					SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T-1
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					AND		AS_OF_DATE NOT IN
							(
							SELECT	MAX(AS_OF_DATE) AS_OF_DATE 
							FROM	[dbo].[T_BBG_CASH_LADDER] BB
							INNER	JOIN [Core].[Calendar] CAL
							ON		CAL.CalendarDate = BB.AS_OF_DATE
							WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
							AND		CAL.ISHOLIDAYUK = 0
							AND		CAL.ISWEEKDAY = 1
							)
					UNION
					SELECT	DISTINCT TOP 5 AS_OF_DATE -- T to T+5
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE > isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					ORDER	BY AS_OF_DATE ASC --// T+5 date range
					)
			AND		C.FUND_SHORT_NAME = @Fund
			AND		C.AS_OF_DATE <= @MAXDATE
UNION 
		SELECT	DISTINCT
					CL.CADIS_SYSTEM_INSERTED as ReportDate,
					CF.[FUND_SHORT_NAME] as Fund,
					CL.[CCY],
					CL.[AS_OF_DATE] AsOfDate,
					cast(CF.[VALUE] as decimal(18,2)) as Value,
					ValueGBP = cast(CF.[Value] / ISNULL(fx.[SPOT_RATE], 1)as decimal(18,2)),
					cast(fx.[SPOT_RATE] as decimal (18,6))as FxSpotRate,
					cast(1 as bit) AS [OVERRIDE]
			FROM	[dbo].[T_OVERRIDE_CASH_LADDER_FUND] CF
			INNER	JOIN [dbo].[T_OVERRIDE_CASH_LADDER] CL
			ON		CL.OVERRIDE_ID = CF.OVERRIDE_ID
			LEFT	OUTER JOIN [dbo].[T_MASTER_FXRATE] fx	
			ON		CONVERT(DATE,fx.DATE) = (SELECT MAX(CONVERT(DATE,DATE)) FROM [dbo].[T_MASTER_FXRATE]) 
			AND		fx.[FROM_ISO_CURRENCY_CODE] = 'GBP'
			AND		fx.[TO_ISO_CURRENCY_CODE] = CL.CCY
			WHERE	CL.AS_OF_DATE IN 
					(
					SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					UNION
					SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T-1
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					AND		AS_OF_DATE NOT IN
							(
							SELECT	MAX(AS_OF_DATE) AS_OF_DATE 
							FROM	[dbo].[T_BBG_CASH_LADDER] BB
							INNER	JOIN [Core].[Calendar] CAL
							ON		CAL.CalendarDate = BB.AS_OF_DATE
							WHERE	AS_OF_DATE <= isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))	
							AND		CAL.ISHOLIDAYUK = 0
							AND		CAL.ISWEEKDAY = 1
							)
					UNION
					SELECT	DISTINCT TOP 5 AS_OF_DATE -- T to T+5
					FROM	[dbo].[T_BBG_CASH_LADDER] BB
					INNER	JOIN [Core].[Calendar] CAL
					ON		CAL.CalendarDate = BB.AS_OF_DATE
					WHERE	AS_OF_DATE > isnull(@Tdate,CONVERT(DATE, ISNULL(@TDate, (SELECT MAX(AS_OF_DATE) AS_OF_DATE FROM [dbo].[T_BBG_CASH_LADDER]))))
					AND		CAL.ISHOLIDAYUK = 0
					AND		CAL.ISWEEKDAY = 1
					ORDER	BY AS_OF_DATE ASC --// T+5 date range
					)
			AND		CF.FUND_SHORT_NAME = @Fund
			AND		CL.AS_OF_DATE <= @MAXDATE
			AND		CF.[VALUE] <> 0
			AND		CL.[ACTIVE] = 1
			)

