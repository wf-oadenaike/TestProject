

CREATE FUNCTION [Access.WebDev].[ufn_CashLadderSummaryFundTotal]
(
    @TDate DATE = NULL
)
RETURNS @Output TABLE (
	[Fund]			VARCHAR(10),
	[AsOfDate]		DATETIME,
	[TMinus1]		DECIMAL(18, 2),
	[T]				DECIMAL(18, 2),
	[Tplus1]		DECIMAL(18, 2),
	[Tplus2]		DECIMAL(18, 2),
	[Tplus3]		DECIMAL(18, 2),
	[Tplus4]		DECIMAL(18, 2),
	[Tplus5]		DECIMAL(18, 2),
	[PctCash]		DECIMAL(18, 2),
	[LastUpdated]	DATETIME
)
AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_CashLadderSummaryFundTotal]
-- 
-- Params: @TDate DATE - Trade date for which the function is to be run for.
-- 
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 21/11/2017 DAP-1484 created
-- R. Dixon: 19/12/2017 DAP-1484 gets last working day's prior to current date for As Of Date, added % Cash field
-- R. Dixon: 24/01/2018 DAP-1665 removes dependency on data from latest file load
-- R. Dixon: 09/02/2018 DAP-1775 resolved divide by zero error if not market value entry for given fund and position date.
-- R. Dixon: 29/03/2018 DAP-1898 only return data for business days
-- R. Dixon: 14/06/2018 DAP-1966 Include cash overrides in totals for individual days for given funds.
-- R. Dixon: 25/06/2018 DAP-2120 Add Last Updated column to returned resultset
-------------------------------------------------------------------------------------- 

BEGIN

		IF  @TDate IS NULL SET @TDate = GETDATE()

		DECLARE @FundTotals TABLE 
			(
			[Fund]			VARCHAR(10),
			[AsOfDate]		DATETIME,
			[ValueGBP]		DECIMAL(18, 2),
			[LastUpdated]	DATETIME
			)
		DECLARE @Dates TABLE 
			(
			[AsOfDate]		DATETIME,
			[OrderID]		INTEGER
			)

		INSERT	INTO @Dates
				SELECT DT.AS_OF_DATE, ROW_NUMBER() OVER (ORDER BY As_Of_Date ASC) AS OrderID
				FROM 
						(
						SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T
						FROM	[dbo].[T_BBG_CASH_LADDER] BB
						INNER	JOIN [Core].[Calendar] CAL
						ON		CAL.CalendarDate = BB.AS_OF_DATE
						WHERE	AS_OF_DATE <= @TDate	
						AND		CAL.ISHOLIDAYUK = 0
						AND		CAL.ISWEEKDAY = 1
				UNION
						SELECT	MAX(AS_OF_DATE) AS_OF_DATE -- T-1
						FROM	[dbo].[T_BBG_CASH_LADDER] BB
						INNER	JOIN [Core].[Calendar] CAL
						ON		CAL.CalendarDate = BB.AS_OF_DATE
						WHERE	AS_OF_DATE <= @TDate	--// T-1 to
						AND		CAL.ISHOLIDAYUK = 0
						AND		CAL.ISWEEKDAY = 1
						AND		AS_OF_DATE NOT IN
								(
								SELECT	MAX(AS_OF_DATE) AS_OF_DATE
								FROM	[dbo].[T_BBG_CASH_LADDER] BB
								INNER	JOIN [Core].[Calendar] CAL
								ON		CAL.CalendarDate = BB.AS_OF_DATE
								WHERE	AS_OF_DATE <= @TDate	--// T-1 to
								AND		CAL.ISHOLIDAYUK = 0
								AND		CAL.ISWEEKDAY = 1
								)
				UNION
						SELECT	DISTINCT TOP 5 AS_OF_DATE -- T to T+5
						FROM	[dbo].[T_BBG_CASH_LADDER] BB
						INNER	JOIN [Core].[Calendar] CAL
						ON		CAL.CalendarDate = BB.AS_OF_DATE
						WHERE	AS_OF_DATE > @TDate
						AND		CAL.ISHOLIDAYUK = 0
						AND		CAL.ISWEEKDAY = 1
						ORDER	BY AS_OF_DATE ASC --// T+5 date range
						) DT

		INSERT INTO @FundTotals
					SELECT	[FUND_SHORT_NAME] AS FUND,
							[AS_OF_DATE],
							ValueGBP = SUM([Value] / ISNULL(fx.[SPOT_RATE], 1)),
							[LastUpdated] = MAX(C.CADIS_SYSTEM_UPDATED)
					FROM	[dbo].[T_BBG_CASH_LADDER] C
					LEFT	OUTER JOIN [dbo].[T_MASTER_FXRATE] fx	
					ON		CONVERT(DATE,fx.DATE) = (SELECT MAX(CONVERT(DATE,DATE)) FROM [dbo].[T_MASTER_FXRATE]) 
					AND		fx.[FROM_ISO_CURRENCY_CODE] = 'GBP'
					AND		fx.[TO_ISO_CURRENCY_CODE] = C.CCY
					WHERE	C.AS_OF_DATE IN 
							(
							SELECT AsOfDate from @Dates
							)
					GROUP	BY [FUND_SHORT_NAME], AS_OF_DATE

		UPDATE	F
		SET		F.ValueGBP = F.ValueGBP + O.ValueGBP
		FROM	@FundTotals F
		INNER	JOIN 	
				(
				SELECT	[FUND_SHORT_NAME],
						d.AsOfDate,
						ValueGBP = SUM([Value] / ISNULL(fx.[SPOT_RATE], 1))
				FROM	[dbo].[T_OVERRIDE_CASH_LADDER] CL
				INNER	JOIN [dbo].[T_OVERRIDE_CASH_LADDER_FUND] CF
				ON		CL.OVERRIDE_ID = CF.OVERRIDE_ID
				LEFT	OUTER JOIN [dbo].[T_MASTER_FXRATE] fx	
				ON		CONVERT(DATE,fx.DATE) = (SELECT MAX(CONVERT(DATE,DATE)) FROM [dbo].[T_MASTER_FXRATE]) 
				AND		fx.[FROM_ISO_CURRENCY_CODE] = 'GBP'
				AND		fx.[TO_ISO_CURRENCY_CODE] = CL.CCY
				INNER	JOIN @Dates d
				ON		d.AsOfDate >= CL.AS_OF_DATE	
				WHERE	CL.AS_OF_DATE IN 
						(
						SELECT AsOfDate from @Dates
						)
				AND		CL.[ACTIVE] = 1
				AND		CF.[VALUE] <> 0
				GROUP	BY [FUND_SHORT_NAME], AsOfDate
				) O
		ON		F.AsOfDate = O.AsOfDate
		AND		F.Fund = O.FUND_SHORT_NAME

		INSERT	@Output
				(
					[Fund],
					[AsOfDate],
					[TMinus1],
					[T],
					[Tplus1],
					[Tplus2],
					[Tplus3],
					[Tplus4],
					[Tplus5],
					[PctCash],
					[LastUpdated]
				)
		SELECT  A.FUND, A.AsOfDate, am.ValueGBP, a.ValueGBP, A1.ValueGBP, a2.ValueGBP, a3.ValueGBP, a4.ValueGBP, a5.ValueGBP, 
				CASE	ISNULL(MV.TOTAL_MARKET_VALUE_BASE,0) WHEN 0
				THEN	0.00
				ELSE
						(
						CASE A.Fund  WHEN 'WIMPCT' THEN 100 * (a2.ValueGBP/MV.TOTAL_MARKET_VALUE_LOCAL) 
						ELSE 100 * (a2.ValueGBP/MV.TOTAL_ACCRUED_MARKET_VALUE_BASE) END 
						) 
				END
				AS		PctCash,
				a.LastUpdated
		FROM
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP, MAX(LastUpdated) as LastUpdated
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 2)
				GROUP	BY Fund, AsOfDate
				) A
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 1)
				GROUP	BY Fund, AsOfDate
				) AM
		ON		AM.Fund = A.FUND
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 3)
				GROUP	BY Fund, AsOfDate
				) A1
		ON		A1.Fund = A.FUND
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 4)
				GROUP	BY Fund, AsOfDate
				) A2
		ON		A2.Fund = A.FUND
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 5)
				GROUP	BY Fund, AsOfDate
				) A3
		ON		A3.Fund = A.FUND
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 6)
				GROUP	BY Fund, AsOfDate
				) A4
		ON		A4.Fund = A.FUND
		LEFT	OUTER JOIN 
				(
				SELECT	Fund, AsOfDate, SUM(ValueGBP) AS ValueGBP 
				FROM	@FundTotals
				WHERE	AsOfDate = (SELECT AsOfDate from @dates where OrderID  = 7)
				GROUP	BY Fund, AsOfDate
				) A5
		ON		A5.Fund = A.FUND
		LEFT	OUTER JOIN dbo.T_MASTER_FND_MARKET_VALUE MV
		ON		MV.FUND_SHORT_NAME = A.Fund
		AND		MV.POSITION_DATE = (SELECT AsOfDate from @dates where OrderID  = 1)
 
		RETURN
   
END





