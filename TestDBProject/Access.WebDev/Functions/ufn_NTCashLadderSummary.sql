CREATE FUNCTION [Access.WebDev].[ufn_NTCashLadderSummary]
(
    @TDate	DATE,
	@Fund	VARCHAR(10) = NULL,
	@MaxDate	DATE
)
returns table
AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_NTCashLadderSummary]
-- 
-- Params:	@TDate DATE - Trade date for which the function is to be run for.
--			@Fund varchar(10) - Fund to filter data set on
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 15/02/2018 DAP-1648 - Created
-- R. Dixon: 29/03/2018 DAP-1898 return data between T-1 and T+5 business days
-------------------------------------------------------------------------------------- 

RETURN (
		SELECT	DISTINCT
				[FILE_DATE] as ReportDate,
				[FUND_SHORT_NAME] as Fund,
				[CCY],
				[C_BSE_CCY],
				[CCY_NAME],
				[D_CURR_DATE] AS AsOfDate,
				[T_NARR_LONG],
				[A_TRAN_RP_BASE],
				[A_TRAN_AMT],
				CASE 
				WHEN [C_BSE_CCY] = 'GBP' THEN [A_TRAN_RP_BASE]
				WHEN [C_BSE_CCY] <> 'GBP' AND [CCY] = 'GBP' THEN [A_TRAN_AMT]
				WHEN [C_BSE_CCY] <> 'GBP' AND [CCY] <> 'GBP' THEN ([A_TRAN_AMT]/ISNULL(FX.[SPOT_RATE], 1))
				END AS ValueGBP,
				CAST(fx.[SPOT_RATE] as decimal (18,6))as FxSpotRate
		FROM	[dbo].[T_NT_CASH_PROJECT] C
		LEFT	OUTER JOIN [dbo].[T_MASTER_FXRATE] fx	
		ON		CONVERT(DATE,fx.DATE) = (SELECT MAX(CONVERT(DATE,[DATE])) FROM [dbo].[T_MASTER_FXRATE]) 
		AND		fx.[FROM_ISO_CURRENCY_CODE] = 'GBP'
		AND		fx.[TO_ISO_CURRENCY_CODE] = C.CCY
		WHERE	
				(
					(
					C.D_CURR_DATE IN 
					(
					-- T - 1
					SELECT MAX([CALENDARDATE])  AS D_CURR_DATE
					FROM   [CORE].[CALENDAR]  
					WHERE  [CALENDARDATE] <= @TDATE 
					AND		ISHOLIDAYUK = 0
					AND		ISWEEKDAY = 1
					AND           [CALENDARDATE] NOT IN
								(
								SELECT MAX([CALENDARDATE]) 
								FROM   [CORE].[CALENDAR]
								WHERE  [CALENDARDATE] <= @TDATE 
								AND		ISHOLIDAYUK = 0
								AND		ISWEEKDAY = 1
								)
					)
					)
					OR	C.D_CURR_DATE IN 
					(
					-- T
					SELECT MAX([CALENDARDATE]) AS D_CURR_DATE
					FROM   [CORE].[CALENDAR]
					WHERE  [CALENDARDATE] <= @TDATE 
					AND		ISHOLIDAYUK = 0
					AND		ISWEEKDAY = 1
					UNION
					-- T+1 TO T+5
					SELECT DISTINCT TOP 5 [CALENDARDATE]
					FROM   [CORE].[CALENDAR]
					WHERE  [CALENDARDATE] > @TDATE 
					AND		ISHOLIDAYUK = 0
					AND		ISWEEKDAY = 1
					ORDER	BY [CALENDARDATE] ASC
					)
				)
		AND		C.[FUND_SHORT_NAME] = @Fund
		AND		C.D_CURR_DATE <= @MAXDATE
		
		)


