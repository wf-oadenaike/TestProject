
CREATE FUNCTION [dbo].[UFN_UNQUOTED_PROJECTION_OMNIS] 
( @PCTGROWTH decimal(20, 10),
@DAYSFWD INT , 
@DAYSBCK INT , 
@FLOW DECIMAL(20, 2),
@OVERDRAFT_AMT DECIMAL(20, 2),
@OVERDRAFT_DATE DATETIME,
@TRANSFER_AMT DECIMAL(20, 2),
@TRANSFER_DATE DATETIME,
@FLOWLAG INT) 
RETURNS @OUTPUT TABLE( 
POSITION_DATE datetime NULL,
FUND_SHORT_NAME varchar(20) NULL,
                                                                                                                                                                                                                            AUM decimal (20, 2) NULL,
                                                                                                                                                                                                                                                TOTAL_UNQUOTED decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                               FLOW decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                                                    FUNDING decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                                                                            REVALUATION decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                                                                                                        AUM_EOD decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                                                                                                                                UNQUOTED_EOD decimal (20, 2) NULL,
                                                                                                                                                                                                                                                                                                                                                                                                             CONCENTRATION_EOD decimal (20, 10) NULL,
                                                                                                                                                                                                                                                                                                                                                                                                                                                HEADROOM decimal (20, 2) NULL ) AS --------------------------------------------------------------------------------------
-- Name: [dbo].[UFN_UNQUOTED_PROJECTION_OMNIS]
--
-- Params:	@PCTGROWTH decimal - projected daily growth of fund in %
--			@DAYSFWD int - number of days into future to project data
--			@DAYSFWD int - number of days back to retrieve data
--			@FLOW decimal - average predicted in/outflow into fund
--			@OVERDRAFT_AMT decimal - overdraft amount for fund
--			@OVERDRAFT_DATE date - date that overdraft facility expires
--			@TRANSFER_AMT decimal - amount to be transferred into/out of fund
--			@TRANSFER_DATE date - amount to be transferred into/out of fund
--			@FLOWLAG int - adjustment for number of days between inflow/outflow record and date the money is received.
--------------------------------------------------------------------------------------
-- History:
-- R. Dixon: 15/12/2017 DAP-1615 created
-- R. Dixon: 21/02/2018 DAP-1814 use UNQUOTED_EOD rather than TOTAL_UNQUOTED to calculate CONCENTRATION_EOD
-- Olu: 05/07/2018 - DAP-2035 Remove T_UNQUOTED_ALLOCATION & T_UNQUOTED_REVALUATION WITH  dbo.vw_UnquotedFundingRevalution
-- Olu 01/08/2018 -  Handle the null  on TECH_STATUS
-- Olu 11/12/2018 - DAP-2408/2407- Add Exclusions for Revaluations and Funding
-- Olu 01/01/2019 - DAP-2500 - Change Funding Calculations
-- Olu 14/02/2019 - DAP-2529 - Sum Funding Calcualtions for AllocationsProvided
--------------------------------------------------------------------------------------
 BEGIN
INSERT INTO @OUTPUT(POSITION_DATE,
                    FUND_SHORT_NAME,
                    AUM,
                    TOTAL_UNQUOTED,
                    FLOW,
                    FUNDING,
                    REVALUATION,
                    AUM_EOD,
                    UNQUOTED_EOD)
SELECT POSITION_DATE,
       FUND_SHORT_NAME,
       AUM,
       TOTAL_UNQUOTED,
       FLOW,
       FUNDING,
       REVALUATION,
       EOD,
       UNQUOTED_EOD
FROM [DBO].[UFN_UNQUOTED_PROJECTION_BASE]('OMNIS1',
                                          @DAYSBCK,
                                          @FLOWLAG) DECLARE @MAX_POS_DATE DATETIME DECLARE @POSITION_DATE DATETIME DECLARE @PREV_AUM_EOD DECIMAL(20,
                                                                                                                                                 2) DECLARE @PREV_UNQUOTED_EOD DECIMAL(20,
                                                                                                                                                                                       2) DECLARE @FUNDING_VAL DECIMAL(20,
                                                                                                                                                                                                                       2) DECLARE @REVAL_VAL DECIMAL(20,
                                                                                                                                                                                                                                                     2) DECLARE @TOTAL_FLOW DECIMAL(20,
                                                                                                                                                                                                                                                                                    2) DECLARE @LATEST_POS_DATE DATETIME -- Get maximum position date based on number of business days to go forward in time for
SET @MAX_POS_DATE =
  ( SELECT CALENDARDATE
   FROM
     (SELECT CALENDARDATE,
             ROW_NUMBER() OVER(
                               ORDER BY CALENDARDATE ASC) AS ROWNUM
      FROM CORE.CALENDAR
      WHERE CALENDARDATE >= CAST(GETDATE() AS DATE)
        AND ISHOLIDAYUK = 0
        AND ISWEEKDAY = 1 ) DATES
   WHERE DATES.ROWNUM = @DAYSFWD )
SET @PREV_AUM_EOD = ISNULL(
                             (SELECT TOP 1 AUM_EOD
                              FROM @OUTPUT
                              ORDER BY POSITION_DATE DESC ),0)
SET @PREV_UNQUOTED_EOD = ISNULL(
                                  (SELECT TOP 1 UNQUOTED_EOD
                                   FROM @OUTPUT
                                   ORDER BY POSITION_DATE DESC ),0)
SET @LATEST_POS_DATE =
  (SELECT MAX(POSITION_DATE)
   FROM T_MASTER_POS
   WHERE FUND_SHORT_NAME = 'OMNIS1') DECLARE FUTURE_CURSOR
CURSOR
FOR
SELECT CALENDARDATE
FROM
  (SELECT CALENDARDATE,
          ROW_NUMBER() OVER(
                            ORDER BY CALENDARDATE ASC) AS ROWNUM
   FROM CORE.CALENDAR
   WHERE CALENDARDATE >= CAST(GETDATE() AS DATE)
     AND ISHOLIDAYUK = 0
     AND ISWEEKDAY = 1 ) DATES
WHERE DATES.ROWNUM <= @DAYSFWD
ORDER BY DATES.CALENDARDATE ASC OPEN FUTURE_CURSOR FETCH NEXT
FROM FUTURE_CURSOR INTO @POSITION_DATE WHILE @@FETCH_STATUS = 0 BEGIN
SET @FUNDING_VAL = 0
SET @REVAL_VAL = 0 -- Get funding value for position date

SET @FUNDING_VAL = ISNULL(
                            (SELECT SUM(allocationamount)
                             FROM
                               (SELECT CASE
                                           WHEN FullAllocationsProvided = 0 THEN MAX (allocationamount)
                                           WHEN FullAllocationsProvided = 1 THEN sum(allocationamount)
                                       END AS allocationamount
                                FROM dbo.vw_UnquotedFundingRevaluation A
                                WHERE FUND_SHORT_NAME = 'OMNIS1'
                                  AND A.TRADE_DATE = @POSITION_DATE
                                  AND A.EDM_SEC_ID NOT IN
                                    (SELECT EDM_SEC_ID
                                     FROM [dbo].[T_REF_SECURITY_EXCEPTIONS] ST
                                     WHERE CAST(Trade_Date AS DATE) >= EffectiveDate
                                       AND ST.FUND_SHORT_NAME = A.FUND_SHORT_NAME )
                                  AND ISNULL(TECH_STATUS, 'NEW') <> 'COMPLETE'
                                  AND REVALUATION_ID IS NULL
                                  AND EDM_SEC_ID IS NOT NULL
                                GROUP BY FullAllocationsProvided) FUNDING ),0) -- Get revaluation value for position date

SET @REVAL_VAL = ISNULL(
                          (SELECT SUM(AllocationAmount) FUNDING
                           FROM dbo.vw_UnquotedFundingRevaluation A
                           WHERE FUND_SHORT_NAME = 'OMNIS1'
                             AND CAST(EXPECTED_ENACTMENT_DATE AS date) = @POSITION_DATE
                             AND A.EDM_SEC_ID NOT IN
                               (SELECT EDM_SEC_ID
                                FROM [dbo].[T_REF_SECURITY_EXCEPTIONS] ST
                                WHERE CAST(EXPECTED_ENACTMENT_DATE AS DATE) >= EffectiveDate
                                  AND ST.FUND_SHORT_NAME = A.FUND_SHORT_NAME )
                             AND isnull(TECH_STATUS, 'NEW') <> 'COMPLETE' ),0)
SET @TOTAL_FLOW = ISNULL (
                            (SELECT SUM(CASE F.FLOW_TYPE
                                            WHEN 'SUBSCRIPTION' THEN MARKET_VALUE
                                            WHEN 'REDEMPTION' THEN MARKET_VALUE * - 1
                                        END)
                             FROM T_MASTER_FUND_FLOW F
                             INNER	JOIN
                               (SELECT DT1.CALENDARDATE,
                                       DT2.CALENDARDATE AS FLOWLAGDATE
                                FROM
                                  ( SELECT CALENDARDATE,
                                           ROW_NUMBER() OVER(
                                                             ORDER BY CALENDARDATE DESC) AS ROWNUM
                                   FROM CORE.CALENDAR
                                   WHERE ISHOLIDAYUK = 0
                                     AND ISWEEKDAY = 1 ) DT1
                                INNER	JOIN
                                  ( SELECT CALENDARDATE,
                                           ROW_NUMBER() OVER(
                                                             ORDER BY CALENDARDATE DESC) - @FLOWLAG AS ROWNUM
                                   FROM CORE.CALENDAR
                                   WHERE ISHOLIDAYUK = 0
                                     AND ISWEEKDAY = 1 ) DT2 ON DT1.ROWNUM = DT2.ROWNUM ) LAG ON LAG.FLOWLAGDATE = CAST(F.TRANSACTION_DATE AS DATE)
                             WHERE F.SOURCE_TYPE = 'CONFIRMED'
                               AND F.FUND_FLOW_TYPE = 'GROSS'
                               AND F.FUND_SHORT_NAME = 'OMNIS1'
                               AND LAG.CALENDARDATE = @POSITION_DATE ), @FLOW) IF CAST(@POSITION_DATE AS DATE) = @OVERDRAFT_DATE BEGIN
SET @TOTAL_FLOW = @TOTAL_FLOW + @OVERDRAFT_AMT END ELSE BEGIN
SET @TOTAL_FLOW = @TOTAL_FLOW END

		IF CAST(@POSITION_DATE AS DATE) = @TRANSFER_DATE BEGIN
SET @TOTAL_FLOW = @TOTAL_FLOW + @TRANSFER_AMT END ELSE BEGIN
SET @TOTAL_FLOW = @TOTAL_FLOW END -- select @PREV_UNQUOTED_EOD, @PREV_AUM_EOD

INSERT INTO @OUTPUT(POSITION_DATE, FUND_SHORT_NAME, AUM, TOTAL_UNQUOTED, FLOW, FUNDING, REVALUATION, AUM_EOD, UNQUOTED_EOD)
SELECT @POSITION_DATE,
       'OMNIS1',
       @PREV_AUM_EOD,
       @PREV_UNQUOTED_EOD,
       @TOTAL_FLOW,
       @FUNDING_VAL,
       @REVAL_VAL,
       (@PREV_AUM_EOD * (1 + @PCTGROWTH/100)) + @REVAL_VAL + @TOTAL_FLOW,
       @PREV_UNQUOTED_EOD + @FUNDING_VAL + @REVAL_VAL
SET @PREV_AUM_EOD = ISNULL(
                             (SELECT TOP 1 AUM_EOD
                              FROM @OUTPUT
                              ORDER BY POSITION_DATE DESC ),0)
SET @PREV_UNQUOTED_EOD = ISNULL(
                                  (SELECT TOP 1 UNQUOTED_EOD
                                   FROM @OUTPUT
                                   ORDER BY POSITION_DATE DESC ),0) -- Calculate Concentration EOD

UPDATE o
SET o.CONCENTRATION_EOD = (o.UNQUOTED_EOD/o.AUM_EOD) * 100
FROM @OUTPUT o -- Calculate Headroom

UPDATE o
SET o.HEADROOM = ((10 - o.CONCENTRATION_EOD) * o.AUM_EOD)/100
FROM @OUTPUT o FETCH NEXT
FROM FUTURE_CURSOR INTO @POSITION_DATE END CLOSE FUTURE_CURSOR DEALLOCATE FUTURE_CURSOR 
RETURN
 END 
