
CREATE FUNCTION [Access.WebDev].[ufn_GetSwingPricing]
(
	@FundName varchar(8) = NULL,
	@PositionDate DATE = NULL
)
 
 
RETURNS
@Output TABLE (
	[FUND_SHORT_NAME] VARCHAR(50) NULL,
	[PRICE_BASIS] VARCHAR(10) NULL,
	[AS_OF_DATE] DATE NULL,
	[AS_AT_DATE] DATETIME NULL,
	[NET_FLOW] MONEY NULL,
	[AUM] MONEY NULL,
	[10DAYAVERATENETFLOW] DECIMAL(18,2) NULL,
	[10DAYNEGATIVEFLOWDAYCOUNT] INT,
	[10DAYPOSITIVEFLOWDAYCOUNT] INT,
	[TMinus0] VARCHAR (20),	
	[TMinus1] VARCHAR (20),	
	[TMinus2] VARCHAR (20),	
	[TMinus3] VARCHAR (20),	
	[TMinus4] VARCHAR (20),	
	[TMinus5] VARCHAR (20),	
	[TMinus6] VARCHAR (20),	
	[TMinus7] VARCHAR (20),	
	[TMinus8] VARCHAR (20),	
	[TMinus9] VARCHAR (20)

	
	)
--AS

---------------------------------------------------------------------------------------- 
---- Name: [Access.WebDev].[ufn_GetSwingPricing]
---- 
---- Params: @PositionDate
---- Returns: Table
---------------------------------------------------------------------------------------- 
---- History:
---- WHO WHEN WHY
---- J.Tapper: 16/05/2017 JIRA: DAP-1033 Replaces Spreadsheet Swing Pricing Daily Control
---- R.Dixon: 04/01/2018 JIRA: OSPBAU-16608 - now passes 1 as @swing parameter into ufn_GetInFlows function
---- R.Dixon: 18/01/2018 JIRA: DAP-1686 - Added logic that when current day`s net flow is in the opposite direction to the 10 day moving average
----										then direction of the dilution adjustment reflecting the direction of the net rolling average 
----										provided that net flows for at least 3 business days of the previous 10 are in the same direction does not apply
---- R.Dixon: 20/04/2018 JIRA: DAP-1686 - Amended to use updated swing pricing logic
---- R.Dixon: 24/04/2018 JIRA: DAP-1954 - calculations to use previous business day's AUM value
-----OLU:     16/11/2018 JIRA: DAP-2393 - Pivot Data for each NET_IN_FLOW 
---------------------------------------------------------------------------------------- 
BEGIN

	DECLARE @D INT
	DECLARE @D2 INT
	DECLARE @Price_Basis VARCHAR(10)



	IF @PositionDate IS NULL
	BEGIN
		SET @PositionDate = CONVERT(DATE,GETDATE())
	END

	DECLARE @AUM TABLE 
		(
		FUND_SHORT_NAME VARCHAR(10),
		[AUM_VALUE] MONEY,
		[ORDERID] INT
		)


	DECLARE @NetFlow TABLE 
		(
		[FUND_SHORT_NAME] VARCHAR(10),
		[FLOW_VALUE] MONEY,
		[ORDERID] INT,
		UPDATED_DATE DATETIME
		)

	DECLARE @Dates TABLE 
		(
		[CALENDARDATE]	DATETIME,
		[ORDERID]		INTEGER
		)
-- TEMP TABLE to store PIVOT DATA 
	DECLARE @TEMP TABLE 
	(
		FUND_SHORT_NAME VARCHAR(20),
		[TMinus0] INT,
		[TMinus1] INT,
		[TMinus2] INT,	
		[TMinus3] INT,	
		[TMinus4] INT,	
		[TMinus5] INT,	
		[TMinus6] INT,	
		[TMinus7] INT,	
		[TMinus8] INT,
		[TMinus9] INT
	
	)

	INSERT	INTO @Dates
	SELECT	CalendarDate, ROW_NUMBER() OVER (ORDER BY CalendarDate ASC) AS OrderID
	FROM	(
			SELECT	TOP 20 CalendarDate
			FROM	Core.Calendar
			WHERE	CalendarDate <= @PositionDate
			AND		IsHolidayUK = 0
			AND		IsWeekday = 1
			ORDER	BY CalendarDate DESC
			) X

	SET	@D=2

	WHILE (@D<=20)
		BEGIN
			INSERT	INTO  @NetFlow ([FUND_SHORT_NAME], FLOW_VALUE, ORDERID, UPDATED_DATE)
			SELECT	FUND_SHORT_NAME, VALUE, @D, LASTUPDATEDDATE
			FROM	[ACCESS.WEBDEV].[UFN_GETINFLOWS]((SELECT CALENDARDATE FROM @Dates where ORDERID = @D),1)
			WHERE	FUND_SHORT_NAME  IN	(SELECT	SOURCE_CODE 
										FROM	[DBO].[T_REF_GENERAL_MAP]
										WHERE	FIELD_NAME ='VALUATION METHOD' AND TARGET_CODE='SWING'
										AND		(SOURCE_CODE = @FUNDNAME OR @FUNDNAME IS NULL)
										)
			AND		FUND_FLOW_TYPE='NET'
			AND		IN_FLOW_DATE = (SELECT CALENDARDATE FROM @Dates where ORDERID = @D)

			INSERT	INTO  @AUM (FUND_SHORT_NAME, AUM_VALUE, ORDERID)
			SELECT	CASE FUND_SHORT_NAME
						WHEN 'WIMOFF' THEN 'WIMEIF'
						ELSE FUND_SHORT_NAME END AS FUND_SHORT_NAME, 
					SUM(VALUE) AS VALUE, 
					@D
			FROM	[ACCESS.WEBDEV].[UFN_GETAUMS]((SELECT CALENDARDATE FROM @Dates where ORDERID = @D - 1))
			GROUP	BY CASE FUND_SHORT_NAME
			WHEN	'WIMOFF' THEN 'WIMEIF'
			ELSE	FUND_SHORT_NAME END

			SET		@D = @D+1
		END

	SET	@D2 = 11

	WHILE (@D2 <= 20)
	BEGIN
		
		INSERT	INTO @OUTPUT ([FUND_SHORT_NAME],
				[PRICE_BASIS],
				[AS_OF_DATE],
				[AS_AT_DATE],
				[NET_FLOW],
				[AUM],
				[10DAYAVERATENETFLOW],
				[10DAYNEGATIVEFLOWDAYCOUNT],
				[10DAYPOSITIVEFLOWDAYCOUNT])
		SELECT	AUM.FUND_SHORT_NAME,
				CASE	WHEN LATEST.FLOW_VALUE / AUM_VALUE > .01 THEN 'OFFER'
						WHEN LATEST.FLOW_VALUE / AUM_VALUE < -.01 THEN 'BID'
						WHEN AV_FLOW_VALUE >= 0 AND LATEST.FLOW_VALUE >= 0 AND POS_FLOW_DAY >= 3 THEN 'OFFER'
						WHEN AV_FLOW_VALUE >= 0 AND LATEST.FLOW_VALUE < 0 AND NEG_FLOW_DAY >= 3 THEN @PRICE_BASIS -- T-1
						WHEN AV_FLOW_VALUE >= 0 AND LATEST.FLOW_VALUE >= 0 AND POS_FLOW_DAY < 3 THEN @PRICE_BASIS -- T-1
						WHEN AV_FLOW_VALUE >= 0 AND LATEST.FLOW_VALUE < 0 AND NEG_FLOW_DAY < 3 THEN 'OFFER'

						WHEN AV_FLOW_VALUE < 0 AND LATEST.FLOW_VALUE > 0 AND POS_FLOW_DAY >= 3 THEN @PRICE_BASIS -- T-1
						WHEN AV_FLOW_VALUE < 0 AND LATEST.FLOW_VALUE < 0 AND NEG_FLOW_DAY >= 3 THEN 'BID'
						WHEN AV_FLOW_VALUE < 0 AND LATEST.FLOW_VALUE > 0 AND POS_FLOW_DAY < 3 THEN 'BID'
						WHEN AV_FLOW_VALUE < 0 AND LATEST.FLOW_VALUE < 0 AND NEG_FLOW_DAY < 3 THEN @PRICE_BASIS  -- T-1
					
				END as SPB,
				(SELECT CALENDARDATE FROM @Dates where ORDERID = @D2),
				LATEST.UPDATED_DATE,
				LATEST.FLOW_VALUE, 
				AUM.AUM_VALUE,
				AV_FLOW_VALUE,
				NEG_FLOW_DAY,
				POS_FLOW_DAY 
				
		FROM 
				(
				SELECT	FUND_SHORT_NAME, AVG(FLOW_VALUE) AS AV_FLOW_VALUE, SUM (CASE WHEN FLOW_VALUE < 0 THEN 1 ELSE 0 END) AS NEG_FLOW_DAY, SUM (CASE WHEN FLOW_VALUE >= 0 THEN 1 ELSE 0 END) AS POS_FLOW_DAY, MAX(CALENDARDATE) AS T_DATE
				FROM	(
						SELECT	FUND_SHORT_NAME, FLOW_VALUE, d.CALENDARDATE
						FROM	@NetFlow n
						INNER	JOIN @Dates d
						ON		d.ORDERID = n.ORDERID
						WHERE	d.orderID BETWEEN (@D2 - 9) AND @D2
						) FL
				GROUP	BY FL.FUND_SHORT_NAME					    
				) NET
		INNER	JOIN
				(
				SELECT	FUND_SHORT_NAME, FLOW_VALUE, UPDATED_DATE, d.CALENDARDATE AS T_DATE, d.ORDERID
				FROM	@NetFlow n
				INNER	JOIN @Dates d
				ON		d.ORDERID = n.ORDERID
				WHERE	d.orderID = @D2
				) LATEST
		ON		LATEST.FUND_SHORT_NAME = NET.FUND_SHORT_NAME
		INNER	JOIN @AUM AUM 
		ON		AUM.FUND_SHORT_NAME = LATEST.FUND_SHORT_NAME
		AND		AUM.ORDERID = LATEST.ORDERID

		SELECT	@PRICE_BASIS = o.PRICE_BASIS 
		FROM	@Output o
		INNER	JOIN @Dates d
		ON		d.CALENDARDATE = o.AS_OF_DATE
		WHERE	d.ORDERID = @D2

		SET		@D2 = @D2 + 1


		END
	-- CURSOR TO LOOP ROUND THE  PIVOT NET_INFLOW DATA  FOR EACH DATE, & FUND AND ALSO  ENTER DATA INTO TEMP TABLE 
DECLARE @FUND  VARCHAR (20)
DECLARE TEMP CURSOR FOR 
SELECT DISTINCT FUND_SHORT_NAME FROM @Output

-- Fetch fund 
OPEN  TEMP
FETCH NEXT FROM TEMP  INTO  @FUND

WHILE @@FETCH_STATUS =  0 
BEGIN


--Loop round fund and store fund and each Pivotted Net_inflow
INSERT INTO @TEMP	
	 SELECT  FUND_SHORT_NAME, [10] as TMinus0 , [9] as TMinus1, [8] as TMinus2,[7] as TMinus3,[6] as TMinus4,[5] as TMinus5,[4] as TMinus6 ,[3] as TMinus7,[2] as TMinus8,[1] as TMinus9
From
(

Select FUND_SHORT_NAME,  NET_FLOW,   
+ CAST(ROW_NUMBER() OVER(ORDER BY AS_OF_DATE)  AS VARCHAR(10)) AS COLUMNSEQUENCE
	 FROM @Output
	 WHERE FUND_SHORT_NAME = @FUND

) as TEMP
PIVOT
(
		MAX(NET_FLOW)
		FOR ColumnSequence IN ([1], [2],[3],[4],[5],[6],[7],[8],[9],[10])

) PIV


FETCH NEXT FROM TEMP INTO @FUND
END 

CLOSE TEMP 
DEALLOCATE TEMP







DELETE FROM @Output where AS_OF_DATE <> (SELECT MAX(AS_OF_DATE) from @output)

 UPDATE @Output 
SET [TMinus0] = case when  T.TMinus0 < 0  THEN 'RED' 
					 when  T.TMinus0 is null THEN 'GREY'	
						ELSE 'GREEN' END,
	[TMinus1] = case when  T.TMinus1 < 0  THEN 'RED'
				     when  T.TMinus1 is null THEN 'GREY'
				 ELSE 'GREEN' END,
	[TMinus2] = case when  T.TMinus2 < 0  THEN 'RED' 
					 when  T.TMinus2 is null THEN 'GREY'
						ELSE 'GREEN' END,
	[TMinus3] = case when  T.TMinus3 < 0  THEN 'RED'
					 when  T.TMinus3 is null THEN 'GREY'	
						 ELSE 'GREEN' END,
	[TMinus4] = case when  T.TMinus4 < 0  THEN 'RED' 
					 when  T.TMinus4 is null THEN 'GREY'
						ELSE 'GREEN' END,
	[TMinus5] = case when  T.TMinus5 < 0  THEN 'RED'
					 when  T.TMinus5 is null THEN 'GREY'
					 ELSE 'GREEN' END,
	[TMinus6] = case when  T.TMinus6 < 0  THEN 'RED' 
					 when  T.TMinus6 is null THEN 'GREY'
						ELSE 'GREEN' END,
	[TMinus7] = case when  T.TMinus7 < 0  THEN 'RED'
					 when  T.TMinus7 is null THEN 'GREY'
						 ELSE 'GREEN' END,
	[TMinus8] = case when  T.TMinus8 < 0  THEN 'RED' 
					  when  T.TMinus8 is null THEN 'GREY'
						ELSE 'GREEN' END,
	[TMinus9] = case when  T.TMinus9 < 0  THEN 'RED' 
					 when  T.TMinus9 is null THEN 'GREY'
						ELSE 'GREEN' END
FROM @Output O
INNER JOIN @TEMP T
ON O.FUND_SHORT_NAME = T.FUND_SHORT_NAME

	RETURN

END

