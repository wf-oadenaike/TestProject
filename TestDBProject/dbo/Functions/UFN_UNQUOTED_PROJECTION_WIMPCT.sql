﻿




CREATE FUNCTION [dbo].[UFN_UNQUOTED_PROJECTION_WIMPCT] 
(

@PCTGROWTH decimal(20,10)  ,
@DAYSFWD int ,
@DAYSBCK int,
@FLOW DECIMAL(20,2),
@OVERDRAFT_AMT DECIMAL(20,2) ,
@OVERDRAFT_DATE DATETIME,
@TRANSFER_AMT DECIMAL(20,2) ,
@TRANSFER_DATE DATETIME ,
@FLOWLAG int  ,
@CASH DECIMAL(20,2) 
)

RETURNS

 @OUTPUT TABLE(
	POSITION_DATE datetime NULL,
	FUND_SHORT_NAME varchar(20) NULL,
	NAV decimal (20,2) NULL,
	TOTAL_UNQUOTED decimal (20,2) NULL,
	FLOW decimal (20,2) NULL,
	FUNDING decimal (20,2) NULL,
	REVALUATION decimal (20,2) NULL,
	NAV_EOD decimal (20,2) NULL,
	UNQUOTED_EOD decimal (20,2) NULL,
	CONCENTRATION_EOD decimal (20,10) NULL,
	NAV_HEADROOM decimal (20,2) NULL,
	GEARING decimal (20,10) NULL,
	CASH decimal (20,2) NULL,
	GROSS_ASSET_VALUE decimal (20,2) NULL,
	ACTUAL_GEARING decimal (20,10) NULL,
	ACTUAL decimal (20,2) NULL,
	NT_BORROWING_BASE decimal (20,2) NULL,
	UQ_VS_GAV decimal (20,10) NULL,
	GAV_HEADROOM decimal (20,2) NULL
	)
AS
-------------------------------------------------------------------------------------- 
-- Name: [dbo].[UFN_UNQUOTED_PROJECTION_WIMPCT] 
-- 
-- Params:	@DAYSFWD number of business days forward in time to project data for
--			@DAYSBCK number of business days back in time to retrieve data for
--			@FLOW average daily flow	
--			@OVERDRAFT_AMT overdraft limit for fund
--			@OVERDRAFT_DATE date overdraft must be repaid by
--			@TRANSFER_AMT transfer amt in/out of fund
--			@TRANSFER_DATE date transfer amt is transferred
--			@FLOWLAG number of days to delay fund flow values being applied (i.e. avg difference between transaction and settlement dates)
--			@CASH available cash in fund
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 30/05/2018 JIRA: DAP-2065 For WIMPCT calculate GAV by multiplying positions by prices for all assets.
-- Olu: 05/07/2018 - DAP-2035 Remove T_UNQUOTED_ALLOCATION & T_UNQUOTED_REVALUATION WITH  dbo.vw_UnquotedFundingRevalution
-- Olu: 10/09/2018 - DAP-2293 Change NT_Borrowing Base Calculation
-- Olu: 18/12/2018 - DAP-2434 Add Distinct to Funding calc
--Olu 03/01/2019 - DAP-2442 Remove Hard Coding

-------------------------------------------------------------------------------------- 

BEGIN

INSERT	INTO @OUTPUT
		(POSITION_DATE, FUND_SHORT_NAME, NAV, TOTAL_UNQUOTED, FLOW, FUNDING, REVALUATION, NAV_EOD, UNQUOTED_EOD, CONCENTRATION_EOD, 
		NAV_HEADROOM, GEARING, CASH, GROSS_ASSET_VALUE, ACTUAL_GEARING, ACTUAL, NT_BORROWING_BASE, UQ_VS_GAV, GAV_HEADROOM)
SELECT	POSITION_DATE, FUND_SHORT_NAME, NAV, TOTAL_UNQUOTED, FLOW, FUNDING, REVALUATION, EOD, UNQUOTED_EOD, 
		100 * (UNQUOTED_EOD/NULLIF(EOD,0)) AS CONCENTRATION_EOD,
		EOD * (0.8 - (UNQUOTED_EOD/NULLIF(EOD,0))) AS HEADROOM,
		100 * (CASH/NULLIF(EOD,0)) AS GEARING,
		CASH,
		EOD - CASH AS GROSS_ASSET_VALUE ,-- now EOD
		100 * (CASH/NULLIF(EOD,0)) AS ACTUAL_GEARING,
		(EOD) - UNQUOTED_EOD AS ACTUAL,
		(0.4 * ((EOD) - UNQUOTED_EOD)) + (0.1 * UNQUOTED_EOD) AS NT_BORROWING_BASE,
		100 * (UNQUOTED_EOD/(NULLIF(EOD,0))) AS UQ_VS_GAV,
		(0.8 - (UNQUOTED_EOD/(NULLIF(EOD,0)))) * (EOD) AS HEADROOM

FROM	[DBO].[UFN_UNQUOTED_PROJECTION_BASE]('WIMPCT', @DAYSBCK, @FLOWLAG)

DECLARE	@MAXPOSDATE DATETIME
DECLARE @POSITION_DATE DATETIME
DECLARE	@PREV_NAV_EOD DECIMAL(20,2)
DECLARE	@PREV_UNQUOTED_EOD DECIMAL(20,2)
DECLARE	@FUNDING_VAL DECIMAL(20,2)
DECLARE	@REVAL_VAL DECIMAL(20,2)
DECLARE @TOTAL_FLOW DECIMAL(20,2)
DECLARE @LATEST_POS_DATE DATETIME

-- Get maximum position date based on number of business days to go forward in time for
SET @MAXPOSDATE = 
		(
		SELECT	CALENDARDATE
		FROM	(SELECT	CALENDARDATE, ROW_NUMBER() OVER(ORDER BY CALENDARDATE ASC) AS ROWNUM
				FROM	CORE.CALENDAR 
				WHERE	CALENDARDATE >= CAST(GETDATE() AS DATE)
				AND		ISHOLIDAYUK = 0
				AND		ISWEEKDAY = 1
				) DATES
		WHERE	DATES.ROWNUM = @DAYSFWD
		)

		SET	@PREV_NAV_EOD = ISNULL((SELECT	TOP 1 NAV_EOD
									FROM	@OUTPUT
									ORDER	BY POSITION_DATE DESC
									),0)

		SET	@PREV_UNQUOTED_EOD = ISNULL((SELECT	TOP 1 UNQUOTED_EOD
										FROM	@OUTPUT
										ORDER	BY POSITION_DATE DESC
								),0)

SET @LATEST_POS_DATE = (SELECT MAX(POSITION_DATE) FROM T_MASTER_POS WHERE FUND_SHORT_NAME = 'WIMPCT')

DECLARE	FUTURE_CURSOR CURSOR FOR
		SELECT	CALENDARDATE
		FROM	(SELECT	CALENDARDATE, ROW_NUMBER() OVER(ORDER BY CALENDARDATE ASC) AS ROWNUM
				FROM	CORE.CALENDAR 
				WHERE	CALENDARDATE >= CAST(GETDATE() AS DATE)
				AND		ISHOLIDAYUK = 0
				AND		ISWEEKDAY = 1
				) DATES
		WHERE	DATES.ROWNUM <= @DAYSFWD
		ORDER	BY DATES.CALENDARDATE ASC

OPEN	FUTURE_CURSOR

FETCH	NEXT FROM FUTURE_CURSOR
INTO	@POSITION_DATE

WHILE	@@FETCH_STATUS = 0
BEGIN 
		SET @FUNDING_VAL = 0
		SET @REVAL_VAL = 0		
		
		
		-- Get funding value for position date
		SET @FUNDING_VAL = ISNULL((SELECT	 sum (distinct (A.allocationamount)) AS FUNDING
							FROM		 dbo.vw_UnquotedFundingRevaluation A
							where		FUND_SHORT_NAME = 'WIMPCT'
							AND			A.TRADE_DATE = @POSITION_DATE
							AND			ISNULL(TECH_STATUS,'NEW') <> 'COMPLETE'
							AND			REVALUATION_ID IS NULL
							AND A.EDM_SEC_ID NOT IN (SELECT EDM_SEC_ID FROM [dbo].[T_REF_SECURITY_EXCEPTIONS] 
									WHERE   (Trade_Date <= EffectiveDate))
							),0)

		-- Get revaluation value for position date
		SET @REVAL_VAL = ISNULL((SELECT	 sum (distinct (A.allocationamount)) FUNDING
								FROM		 dbo.vw_UnquotedFundingRevaluation A
							WHERE		FUND_SHORT_NAME = 'WIMPCT'
							AND			EXPECTED_ENACTMENT_DATE = @POSITION_DATE
							AND			ISNULL(TECH_STATUS,'NEW') <> 'COMPLETE'
							),0)
	

							


		-- get flow values taking into account flow lag
		SET @TOTAL_FLOW = ISNULL
						((SELECT SUM(CASE F.FLOW_TYPE WHEN 'SUBSCRIPTION' THEN MARKET_VALUE WHEN 'REDEMPTION' THEN MARKET_VALUE * - 1 END) 
						FROM	T_MASTER_FUND_FLOW F
						INNER	JOIN 
								(SELECT	DT1.CALENDARDATE, DT2.CALENDARDATE AS FLOWLAGDATE
								FROM	(
										SELECT	CALENDARDATE, ROW_NUMBER() OVER(ORDER BY CALENDARDATE DESC ) AS ROWNUM
										FROM	CORE.CALENDAR 
										WHERE	ISHOLIDAYUK = 0
										AND		ISWEEKDAY = 1
										) DT1
								INNER	JOIN 
										(
										SELECT	CALENDARDATE, ROW_NUMBER() OVER(ORDER BY CALENDARDATE DESC ) - @FLOWLAG AS ROWNUM
										FROM	CORE.CALENDAR 
										WHERE	ISHOLIDAYUK = 0
										AND		ISWEEKDAY = 1
										) DT2
								ON		DT1.ROWNUM = DT2.ROWNUM
								) LAG
						ON		LAG.FLOWLAGDATE = CAST(F.TRANSACTION_DATE AS DATE)
						WHERE	F.SOURCE_TYPE = 'CONFIRMED'
						AND		F.FUND_FLOW_TYPE = 'GROSS' 
						AND		F.FUND_SHORT_NAME = 'WIMPCT'
						AND		LAG.CALENDARDATE = @POSITION_DATE
						), @FLOW)

		-- get total flow amount
		IF CAST(@POSITION_DATE AS DATE) = @OVERDRAFT_DATE
		BEGIN
		SET @TOTAL_FLOW = @TOTAL_FLOW + @OVERDRAFT_AMT
		END
		ELSE
		BEGIN
		SET @TOTAL_FLOW = @TOTAL_FLOW
		END

		IF CAST(@POSITION_DATE AS DATE) = @TRANSFER_DATE
		BEGIN
		SET @TOTAL_FLOW = @TOTAL_FLOW + @TRANSFER_AMT
		END
		ELSE
		BEGIN
		SET @TOTAL_FLOW = @TOTAL_FLOW
		END

-- select @PREV_UNQUOTED_EOD, @PREV_AUM_EOD

		INSERT	INTO @OUTPUT(POSITION_DATE, FUND_SHORT_NAME, NAV, TOTAL_UNQUOTED, FLOW, FUNDING, REVALUATION, NAV_EOD, UNQUOTED_EOD, CASH)
		SELECT	@POSITION_DATE, 
				'WIMPCT', 
				@PREV_NAV_EOD,
				@PREV_UNQUOTED_EOD,
				@TOTAL_FLOW, 
				@FUNDING_VAL, 
				@REVAL_VAL, 
				(@PREV_NAV_EOD * (1 + @PCTGROWTH/100)) + @REVAL_VAL + @TOTAL_FLOW, 
				@PREV_UNQUOTED_EOD + @FUNDING_VAL + @REVAL_VAL,
				@CASH

		SET	@PREV_NAV_EOD = ISNULL((SELECT	TOP 1 NAV_EOD
									FROM	@OUTPUT
									ORDER	BY POSITION_DATE DESC
									),0)

		SET	@PREV_UNQUOTED_EOD = ISNULL((SELECT	TOP 1 UNQUOTED_EOD
										FROM	@OUTPUT
										ORDER	BY POSITION_DATE DESC
								),0)
	

FETCH	NEXT FROM FUTURE_CURSOR
INTO	@POSITION_DATE

END
CLOSE FUTURE_CURSOR
DEALLOCATE FUTURE_CURSOR

		-- Determine calculated fields
		UPDATE	o
		SET o.CONCENTRATION_EOD =  100 * (UNQUOTED_EOD/NULLIF(NAV_EOD,0)),
		o.NAV_HEADROOM = NAV_EOD * (0.8 - (UNQUOTED_EOD/NULLIF(NAV_EOD,0))),
		o.GEARING = -1 * (100 * (CASH/NULLIF(NAV_EOD,0))),
		o.GROSS_ASSET_VALUE = NAV_EOD ,
		o.ACTUAL_GEARING = -1 * (100 * (CASH/NULLIF(NAV_EOD,0))),
		o.ACTUAL = (NAV_EOD) - UNQUOTED_EOD,
		o.NT_BORROWING_BASE = (0.4 * NAV_EOD) + (0.1 * UNQUOTED_EOD),
		--o.NT_BORROWING_BASE = (0.4 * ((NAV_EOD) - UNQUOTED_EOD)) + (0.1 * UNQUOTED_EOD),
		o.UQ_VS_GAV = 100 * (UNQUOTED_EOD/(NULLIF(NAV_EOD,0))),
		o.GAV_HEADROOM = (0.8 - (UNQUOTED_EOD/(NULLIF(NAV_EOD,0)))) * (NAV_EOD)
		FROM	@OUTPUT o

RETURN

END




