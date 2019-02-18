
CREATE PROCEDURE [TCA].[usp_TCAExtract] AS
-------------------------------------------------------------------------------------- 
-- Name:			[TCA].[usp_TCAExtract]
-- 
-- Note:			
-- 
-- Author:			R Carter
-- Date:			14/11/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		extract data for sending to TCA (Based on Dave Fanning script)
-- R. DIXON			20/11/2017 DAP-1541 Correction to the Trade Order Size calculation
-- W.Stubbs			21/11/2017 DAP-1541 Further changes as above.
-------------------------------------------------------------------------------------- 
BEGIN TRY

	SET NOCOUNT ON;

	DECLARE	@strProcedureName		VARCHAR(100)	= '[TCA].[usp_TCAExtract]';
	
	DECLARE @IDs TABLE
	(
		ISIN [varchar](50) NULL, 
		CUSIP [varchar](50) NULL, 
		SEDOL [varchar](50) NULL, 
		Exchange [varchar](50) NULL, 
		Currency [varchar](50) NULL
	);


	-- only for last 5 dates for EXEC_DATE

	INSERT INTO @IDs
	(ISIN, CUSIP, SEDOL, Exchange, Currency)
	SELECT DISTINCT ISIN, CUSIP, SEDOL, Exchange, Currency
	FROM [dbo].[T_BBG_TCA_EMSX_Trade_fills]
	WHERE CAST(EXEC_DATE as date) IN (SELECT DISTINCT TOP 5 CAST(EXEC_DATE as date) FROM [dbo].[T_BBG_TCA_EMSX_Trade_fills] ORDER BY CAST(EXEC_DATE as date) DESC);


/* #TIMESTAMPS - TCA Events
This 'horrible' section is due to the structure (audit log) of the Bloomberg data.
TimeStamps are derived from the audited events for a trade order, we get the earliest 
occurence of an event. These events are then intepreted as TCA events by ITG.

For aggregated trades we try to identify the point at which a trade was aggregated FROM or TO,
these aggregation timestamps are then used to chain trades together so the order trade flow can 
be seen across the TimeStamps of multiple orders. 

TCA Events are gathered for the last 5 business days.

Note: there are still problems with a minority of trades that are very complex where there have 
been numerous aggregations and the intepretation of the audit data appears incomplete.
*/

	DECLARE @TradeEventTimeStamps TABLE
	(

		[OrderNumber] [integer] NULL,
		[DecisionDateTime] [datetime] NULL,
		[OrderStartDateTime] [datetime] NULL,
		[ReleaseDateTime] [datetime] NULL,
		[TraderDateTime] [datetime] NULL,
		[BrokerDateTime] [datetime] NULL,
		[TradeDateTime] [datetime] NULL,
		[AggregatedToDateTime] [datetime] NULL,
		[AggregatedFromDateTime] [datetime] NULL,
		[AggregatedDateTime] [datetime] NULL,
		[AggregatedTo] [varchar](10) NULL,
		[AggregatedFrom] [varchar](10) NULL,
		[AIM_MasterTicketId] [integer] NULL,
		[RoutedAmount] [float] NULL,
		[Trader] [varchar](12) NULL,
		[OrderSize]  [float] NULL
	);

	INSERT INTO @TradeEventTimeStamps
	(OrderNumber,DecisionDateTime,OrderStartDateTime,ReleaseDateTime,TraderDateTime,BrokerDateTime,TradeDateTime,AggregatedToDateTime,AggregatedFromDateTime,AggregatedDateTime,
	AggregatedTo,AggregatedFrom,AIM_MasterTicketId,RoutedAmount,Trader,OrderSize)
	SELECT
		[OrderNumber] = X.I_TSORDNUM,
		[DecisionDateTime] = (CASE	WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[DecisionDateTime], X.[AggregatedFromDateTime])) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[DecisionDateTime], X.[AggregatedToDateTime]))
								ELSE MIN(X.[DecisionDateTime]) END),
		[OrderStartDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[OrderStartDateTime], X.[AggregatedFromDateTime])) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[OrderStartDateTime], X.[AggregatedToDateTime])) 
								ELSE MIN(X.[OrderStartDateTime]) END),
		[ReleaseDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[ReleaseDateTime], X.[AggregatedFromDateTime]))	
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[ReleaseDateTime], X.[AggregatedToDateTime])) 
								ELSE MIN(X.[ReleaseDateTime]) END),
		[TraderDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[TraderDateTime], X.[AggregatedFromDateTime])) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[TraderDateTime], X.[AggregatedToDateTime])) 
								ELSE MIN(X.[TraderDateTime]) END),
		[BrokerDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[BrokerDateTime], X.[AggregatedFromDateTime])) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[BrokerDateTime], X.[AggregatedToDateTime])) 
								ELSE MIN(X.[BrokerDateTime]) END),
		[TradeDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(ISNULL(X.[TradeDateTime], X.[AggregatedFromDateTime])) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(ISNULL(X.[BrokerDateTime], X.[AggregatedToDateTime])) 
								ELSE MIN(X.[TradeDateTime]) END),
		[AggregatedToDateTime] = MIN(X.[AggregatedToDateTime]),
		[AggregatedFromDateTime] = MIN(X.[AggregatedFromDateTime]),
		[AggregatedDateTime] = (CASE WHEN MIN(X.I_AGGRFROM) IS NOT NULL THEN MIN(X.[AggregatedFromDateTime]) 
								WHEN MIN(X.I_AGGRTO) IS NOT NULL THEN MIN(X.[AggregatedToDateTime]) END),
		[AggregatedTo] = MIN(X.I_AGGRTO),
		[AggregatedFrom] = MIN(X.I_AGGRFROM),
		[AIM_MasterTicketId] = MIN(X.AIM_MasterTicketId),
		[RoutedAmount] = SUM(RoutedAmount),
		[Trader] = MIN(X.Trader),
		[OrderSize] = SUM(X.OrderSize)
	FROM
	(
		SELECT
			I_TSORDNUM,
			C_EVENT,
			[DecisionDateTime] = (CASE WHEN C_EVENT IN ('SELL ORDER PRE ALLOCATED', 'BUY ORDER PRE ALLOCATED') THEN MIN(Y.D_DATE_TIME) ELSE NULL END),
			[OrderStartDateTime] = (CASE WHEN C_EVENT IN ('ORDER SENT FOR VMGR APPROVAL', 'COMPLIANCE STATUS: PENDING') THEN MIN(Y.D_DATE_TIME) ELSE NULL END),
			[ReleaseDateTime] = (CASE WHEN C_EVENT = 'ACTIVATED ORDER' THEN MIN(Y.D_DATE_TIME) ELSE NULL END), 
			[TraderDateTime] = (CASE WHEN C_EVENT IN ('CHANGED ASGND TRDR', 'COMPLIANCE STATUS: APPROVED', 'COMPLIANCE STATUS: PASSED') THEN MIN(Y.D_DATE_TIME) ELSE NULL END), 
			[BrokerDateTime] = (CASE WHEN C_EVENT IN ('E-SENT: ROUTED TO ELEC BRKR', 'TRADER FIRMED UP', 'M-WORK: ROUTED TO MANU BRKR')  THEN MIN(Y.D_DATE_TIME) ELSE NULL END),
			[TradeDateTime] = (CASE WHEN C_EVENT IN ('E-PFIL: ELEC PARTFILL OCCURRED', 'E-FILL: ELEC FILL OCCURRED', 'M-FILL: MANU FILL OCCURRED') THEN MIN(Y.D_DATE_TIME) ELSE NULL END),
			[AggregatedToDateTime] = (CASE WHEN C_EVENT IN ('AGGREGATED TO') THEN MIN(Y.D_DATE_TIME) ELSE NULL END),
			[AggregatedFromDateTime] = (CASE WHEN C_EVENT IN ('AGGREGATED FROM') THEN MAX(Y.D_DATE_TIME) ELSE NULL END),
			AIM_MasterTicketId = (CASE WHEN C_EVENT IN ('ORDER ALLOCATED', 'CANCEL REMAINING') THEN MIN(Y.I_MTKTNUM) ELSE NULL END),
			OrderSize = (CASE WHEN C_EVENT IN ('CHANGED ASGND TRDR', 'ACTIVATED ORDER') THEN SUM(Y.F_QUANTITY) ELSE NULL END),
			RoutedAmount = (CASE WHEN C_EVENT IN ('E-SENT: ROUTED TO ELEC BRKR', 'TRADER FIRMED UP', 'M-WORK: ROUTED TO MANU BRKR')  THEN SUM(Y.F_ROUTAMT) ELSE NULL END),
			Trader = (CASE WHEN C_EVENT IN ('E-PFIL: ELEC PARTFILL OCCURRED', 'E-FILL: ELEC FILL OCCURRED', 'M-FILL: MANU FILL OCCURRED') THEN MAX(Y.C_USER) ELSE NULL END),
			I_AGGRTO = MIN(Y.I_AGGRTO),
			I_AGGRFROM = MAX(Y.I_AGGRFROM)
		FROM 
			(
				SELECT
						cast(I_TSORDNUM as int) as I_TSORDNUM,
						C_EVENT,
						D_DATE_TIME = CONVERT(DATETIME, CONVERT(CHAR(8), D_DATE, 112) + ' ' + CONVERT(CHAR(8), T_TIME, 108)),
						I_AGGRTO,
						I_AGGRFROM,
						cast(I_MTKTNUM as int) as I_MTKTNUM,
						cast(F_QUANTITY as float) as F_QUANTITY,
						cast(F_ROUTAMT as float) as F_ROUTAMT,
						C_USER
				FROM 
					[dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT]     
				WHERE 
					C_EVENT IN ('AGGREGATED TO', 'AGGREGATED FROM', 'CANCEL REMAINING', 'M-FILL: MANU FILL OCCURRED', 'M-WORK: ROUTED TO MANU BRKR', 'SELL ORDER PRE ALLOCATED', 'BUY ORDER PRE ALLOCATED', 'ORDER SENT FOR VMGR APPROVAL', 'COMPLIANCE STATUS: PENDING', 'ACTIVATED ORDER', 'COMPLIANCE STATUS: PASSED', 'CHANGED ASGND TRDR', 'COMPLIANCE STATUS: APPROVED', 'TRADER FIRMED UP', 'E-SENT: ROUTED TO ELEC BRKR', 'E-PFIL: ELEC PARTFILL OCCURRED', 'E-FILL: ELEC FILL OCCURRED', 'ORDER ALLOCATED')
				AND I_TSORDNUM IN 
				(
					SELECT DISTINCT I_TSORDNUM
					FROM 
					[dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT]
					WHERE 
                     CAST(D_DATE as date) IN (SELECT DISTINCT TOP 5 CAST(D_DATE as date) FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] ORDER BY CAST(D_DATE as date) DESC)
				)
			) Y
		GROUP BY 
			Y.I_TSORDNUM,
			Y.C_EVENT, 
			Y.D_DATE_TIME
	) x
	GROUP BY 
		X.I_TSORDNUM;


/*
 CANCELLED Orders
Remove deleted orders, these are not analysed.
*/
	DELETE FROM @TradeEventTimeStamps 
	WHERE OrderNumber IN (SELECT DISTINCT I_TSORDNUM FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] 
	WHERE C_EVENT IN ('ORDER CANCELLED', 'MASTER POSTTRAD CANCELLED', 'CANCEL: ORDER WAS DELETED'));

/*
The following 'horrible' section is a work around required for trades orders fulfilled by multiple brokers.
The Bloomberg audit data does not correctly reflect the amount each broker is routed so we use the execution 
fill level data to determine this. The TimeStamps are crucial to map the broker execution against the broker
in the audit data.
*/

	DECLARE @RoutedAmounts TABLE
	(
		[OrderNumber] [integer] NULL,
		[ExecTranBroker] [varchar](15) NULL,
		[RoutedAmount] [float] NULL,
		[ExecAsOfDate] [date] NULL,
		[BrokerOrderCreateDateTime] [datetime] NULL
	);

	INSERT INTO @RoutedAmounts
	([OrderNumber],
	[ExecTranBroker],
	[RoutedAmount],
	[ExecAsOfDate],
	[BrokerOrderCreateDateTime])
	SELECT E.[Order_Number], 
		   E.[Exec/Tran_Broker], 
		   MAX(CAST(E.[Routed_Amount] as float)) AS RoutedAmount, 
		   Cast(E.[Exec_As_of_Date] as date) AS ExecAsOfDate,
		   CONVERT(DATETIME, CONVERT(CHAR(8), E.[Order_Create_Date], 112) + ' ' + CONVERT(CHAR(8), E.[Order_Entry_Time], 108)) AS BrokerOrderCreateDateTime
	FROM [dbo].[T_BBG_TCA_EMSX_Trade_fills] E
	WHERE E.[Exec_Type] <> 'CANCEL'
	AND CAST(E.EXEC_DATE as date) IN (SELECT DISTINCT TOP 5 CAST(EXEC_DATE as date) FROM [dbo].[T_BBG_TCA_EMSX_Trade_fills] ORDER BY CAST(EXEC_DATE as date) DESC)
	AND (E.[Exec_Prev_Seq_Number] = 0 
	OR E.[Exec_Seq_Number] NOT IN (SELECT X.[Exec_Prev_Seq_Number] 
									FROM [dbo].[T_BBG_TCA_EMSX_Trade_fills] X 
									WHERE X.[Order_Number] = E.[Order_Number] 
									AND E.[Exec/Tran_Broker] = X.[Exec/Tran_Broker]))
	GROUP BY E.[Order_Number], E.[Exec/Tran_Broker], Cast(E.[Exec_As_of_Date] as date),
	CONVERT(DATETIME, CONVERT(CHAR(8), E.[Order_Create_Date], 112) + ' ' + CONVERT(CHAR(8), E.[Order_Entry_Time], 108));

/* TCA Allocations Data 'File'
Next two statements find trade orders without an allocation (no AIM_MasterTicketId) and sets the TCA event datetime
to the earliest event on the final allocated trade.
*/
	DECLARE @AggregatedTrades TABLE
	(
		[AggregatedTo] [integer] NULL,
		[DecisionDateTime] [datetime] NULL,
		[OrderStartDateTime] [datetime] NULL,
		[ReleaseDateTime] [datetime] NULL,
		[TraderDateTime] [datetime] NULL,
		[BrokerDateTime] [datetime] NULL,
		[TradeDateTime] [datetime] NULL
	);

	INSERT INTO @AggregatedTrades
		([AggregatedTo],
		 [DecisionDateTime],
		 [OrderStartDateTime],
		 [ReleaseDateTime],
		 [TraderDateTime],
		 [BrokerDateTime],
		 [TradeDateTime])
	SELECT
		[AggregatedTo],
		[DecisionDateTime] = MIN([DecisionDateTime]),
		[OrderStartDateTime] = MIN([OrderStartDateTime]),
		[ReleaseDateTime] = MIN([ReleaseDateTime]),
		[TraderDateTime] = MIN([TraderDateTime]),
		[BrokerDateTime] = MIN([BrokerDateTime]),
		[TradeDateTime] = MIN([TradeDateTime])
	FROM 
		@TradeEventTimeStamps	
	WHERE 
		AggregatedTo > 0
	AND AIM_MasterTicketId IS NULL
	GROUP BY 
		AggregatedTo;	

	UPDATE TRD SET
		[DecisionDateTime] = (CASE WHEN AGG.[DecisionDateTime] < TRD.[DecisionDateTime] THEN AGG.[DecisionDateTime] ELSE TRD.[DecisionDateTime] END),
		[OrderStartDateTime] = (CASE WHEN AGG.[OrderStartDateTime] < TRD.[OrderStartDateTime] THEN AGG.[OrderStartDateTime] ELSE TRD.[OrderStartDateTime] END),
		[ReleaseDateTime] = (CASE WHEN AGG.[ReleaseDateTime] < TRD.[ReleaseDateTime] THEN AGG.[ReleaseDateTime] ELSE TRD.[ReleaseDateTime] END),
		[TraderDateTime] = (CASE WHEN AGG.[TraderDateTime] < TRD.[TraderDateTime] THEN AGG.[TraderDateTime] ELSE TRD.[TraderDateTime] END),
		[BrokerDateTime] = (CASE WHEN AGG.[BrokerDateTime] < TRD.[BrokerDateTime] THEN AGG.[BrokerDateTime] ELSE TRD.[BrokerDateTime] END),
		[TradeDateTime] = (CASE WHEN AGG.[TradeDateTime] < TRD.[TradeDateTime] THEN AGG.[TradeDateTime] ELSE TRD.[TradeDateTime] END)
	FROM
		@TradeEventTimeStamps	TRD
	INNER JOIN @AggregatedTrades AGG 
	ON TRD.OrderNumber = AGG.AggregatedTo
	WHERE 
		TRD.AIM_MasterTicketId IS NOT NULL;


/* TCA Allocations Data 'File'
This query retrieves the individual Allocations for Trade Orders from the Bloomberg Audit File.

Notes: 
The subqueries for both OrderSize, TraderSize and BrokerSize are required to aggregate order amounts from different audit events from the Allocation event.
The use of 'magic numbers' transforms for I_IDENTTYPE and C_REASONCODE are required as no reference table for these exists, though could be created.

Need to replace the following with good data sources 
	#tmpIDs			- CUSIP data source
	#dbo.SecMaster	- Security master
	#dbo.Divs2		- One-off dividends list from Mo, this will be replaced with an Investment Operations entered field.
*/

-- Clear down output table
	DELETE FROM [TCA].[Trade_Order_Output];

	INSERT INTO [TCA].[Trade_Order_Output]
		(DecisionDateTime,
		OrderId,
		OrderStartDateTime,
		OrderSize,
		ReleaseId,
		ReleaseDateTime,
		TraderBlockId,
		TraderDateTime,
		TraderSize,
		BrokerId,
		BrokerDateTime,
		BrokerSize,
		Symbol,
		SymbolType,
		Side,
		Shares,
		AllocationDateTime,
		Price,
		Account,
		Trader,
		Exchange,
		Country,
		Currency,
		UDMFUND,
		UDMSTRATEGY,
		UDMPMINSTRUCTIONS,
		UDMPMORDERREASON,
		UDMTRADEDESK,
		UDMPROGRAMID,
		TRADEID,
		SalesCommission,
		BrokerCommission,
		ExchangeFee,
		WithholdingTax,
		TransferTax,
		StampDuty,
		MiscellaneousFee,
		Dividend,
		DividendCCY,
		SpecialDividend,
		SpecialDividendCCY,
		Note1,
		Note2,
		Note3,
		C_EVENT,
		AggregatedTo,
		AggregatedFrom,
		C_SECURITY)
	SELECT
		DecisionDateTime = ISNULL(T.DecisionDateTime, T.[AggregatedDateTime]),
		OrderId = T.OrderNumber,
		OrderStartDateTime = ISNULL(T.OrderStartDateTime, T.[AggregatedDateTime]),
		OrderSize = ISNULL(ISNULL((
					SELECT SUM(Y.F_QUANTITY) FROM (
						SELECT MAX(CAST(X2.F_QUANTITY as float)) AS F_QUANTITY FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] X2 WHERE X2.I_TSORDNUM = A.I_TSORDNUM and X2.C_EVENT IN ('E-SENT: ROUTED TO ELEC BRKR', 'ACTIVATED ORDER') GROUP BY X2.I_TKTNUM
					) Y ), T.OrderSize), A.F_QUANTITY),
		ReleaseId = ISNULL(T.Trader, 'T') + '_' + ISNULL(A.C_BROKER, 'B') + '_' + CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 112) + REPLACE(CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 108), ':', '_'),
		ReleaseDateTime = ISNULL(T.ReleaseDateTime, T.[AggregatedDateTime]),
		TraderBlockId = T.AIM_MasterTicketId,
		TraderDateTime = ISNULL(T.TraderDateTime, T.[AggregatedDateTime]),
		TraderSize =  ISNULL(ISNULL((
					SELECT SUM(Y.F_QUANTITY) FROM (
						SELECT MAX(CAST(X2.F_QUANTITY as float)) AS F_QUANTITY FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] X2 WHERE X2.I_TSORDNUM = A.I_TSORDNUM and X2.C_EVENT IN ('E-PFIL: ELEC PARTFILL OCCURRED', 'E-FILL: ELEC FILL OCCURRED', 'M-FILL: MANU FILL OCCURRED') GROUP BY X2.I_TKTNUM
					) Y ), T.OrderSize), A.F_QUANTITY),
		BrokerId = A.C_BROKER,
		BrokerDateTime = ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]),
		BrokerSize = ISNULL((SELECT SUM(CONVERT(FLOAT, E.RoutedAmount)) FROM @RoutedAmounts E
					WHERE  E.[OrderNumber]  = T.OrderNumber 
					AND  E.[ExecTranBroker] = A.C_BROKER
					AND CAST (E.ExecAsOfDate as date) =  CAST (A.D_DATE as date)
					GROUP BY CAST(E.ExecAsOfDate as date), E.[ExecTranBroker]),  A.F_QUANTITY),
		[Symbol] = A.C_IDENTIFIER, 
		[SymbolType] = (CASE	WHEN A.I_IDENTTYPE = 1 THEN 'CUSIP'
							WHEN A.I_IDENTTYPE = 8 THEN 'ISIN'
							WHEN A.I_IDENTTYPE = 30 THEN 'PRIV' ELSE '' END),
		[Side] = A.C_SIDE, 
		[Shares] = A.F_QUANTITY,
		[AllocationDateTime] = ISNULL(CONVERT(DATETIME, CONVERT(CHAR(8), A.D_DATE, 112) + ' ' + CONVERT(CHAR(8), A.T_TIME, 108)), T.[AggregatedDateTime]),
		[Price] = A.F_PRICE, 
		[Account] = A.C_ACCOUNT,
		[Trader] = ISNULL(T.Trader, A.C_USER),
		[Exchange] = RIGHT(A.C_SECURITY, LEN(A.C_SECURITY) - CHARINDEX(' ', A.C_SECURITY)),
		[Country] = ISNULL(S.ISSUE_COUNTRY_ISO, 'US'),
		[Currency]  = '', 
		[UDMFUND] = A.C_ACCOUNT,
		[UDMSTRATEGY] = A.C_AIMSTRATEGY,
		[UDMPMINSTRUCTIONS] = A.C_ROUTE_INSTRUCTION,
		[UDMPMORDERREASON] = (CASE	WHEN A.C_REASONCODE = 1 THEN 'CU'
								WHEN A.C_REASONCODE = 2 THEN 'EX'
								WHEN A.C_REASONCODE = 3 THEN 'PL'
								WHEN A.C_REASONCODE = 4 THEN 'IP'
								WHEN A.C_REASONCODE = 5 THEN 'CR'
								WHEN A.C_REASONCODE = 6 THEN 'UQ'
								WHEN A.C_REASONCODE = 7 THEN 'RT'
								WHEN A.C_REASONCODE = 8 THEN 'BB' ELSE '' END),
		[UDMTRADEDESK] = '',
		[UDMPROGRAMID] = '',
		[TRADEID] = A.I_TKTNUM,
		SalesCommission = ABS(A.C_SCOM_VALUE), --REVERSE(left(REVERSE(A.C_SCOM), charindex(' ',REVERSE(A.C_SCOM))-1))
		BrokerCommission = ABS(A.C_BCOM_VALUE), --REVERSE(left(REVERSE(A.C_BCOM), charindex(' ',REVERSE(A.C_BCOM))-1))
		ExchangeFee = ABS(A.C_EFEE_VALUE),  --REVERSE(left(REVERSE(A.C_EFEE), charindex(' ',REVERSE(A.C_EFEE))-1))
		WithholdingTax = ABS(A.C_WTAX_VALUE),  --REVERSE(left(REVERSE(A.C_WTAX), charindex(' ',REVERSE(A.C_WTAX))-1))
		TransferTax = ABS(A.C_TTAX_VALUE),  --REVERSE(left(REVERSE(A.C_TTAX), charindex(' ',REVERSE(A.C_TTAX))-1))
		StampDuty = ABS(A.C_SDTY_VALUE),  --REVERSE(left(REVERSE(A.C_SDTY), charindex(' ',REVERSE(A.C_SDTY))-1))
		MiscellaneousFee = ABS(A.C_MFEE_VALUE), --REVERSE(left(REVERSE(A.C_MFEE), charindex(' ',REVERSE(A.C_MFEE))-1))
		
		[Dividend] = (CASE WHEN A.C_REASONCODE IN (1, 2) THEN ISNULL(A.C_LONG1, '') ELSE '' END),
        [DividendCCY] = (CASE WHEN A.C_REASONCODE IN (1, 2) THEN ISNULL(A.C_LONG2, '') ELSE '' END),
        [SpecialDividend] = (CASE WHEN A.C_REASONCODE IN (1, 2) THEN ISNULL(A.C_LONG3, '') ELSE '' END),
        [SpecialDividendCCY] = (CASE WHEN A.C_REASONCODE IN (1, 2) THEN ISNULL(A.C_LONG4, '') ELSE '' END),
		
		Note1 = '',
		Note2 = '',
		Note3 = '',
		A.C_EVENT,
		AggregatedTo = ISNULL(T.AggregatedTo, ''),
		AggregatedFrom = ISNULL(T.AggregatedFrom, ''),
		C_SECURITY = ISNULL(A.C_SECURITY, '')
	FROM 
		[dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] A
	INNER JOIN
		@TradeEventTimeStamps	T ON A.I_TSORDNUM = T.OrderNumber
	LEFT OUTER JOIN
		@IDs						I ON A.C_IDENTIFIER = I.CUSIP
	LEFT OUTER JOIN 
		dbo.T_MASTER_SEC				S ON A.C_IDENTIFIER = S.ISIN
	--LEFT OUTER JOIN 
	--	[dbo].[Divs2]				D ON A.I_TSORDNUM = D.[OrderId] AND A.I_TKTNUM = D.TradeID
	WHERE 
	A.C_EVENT IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION')
	AND A.I_TKTNUM NOT IN (SELECT I_TKTNUM FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] x WHERE x.I_TSORDNUM = a.I_TSORDNUM AND x.C_EVENT IN ('ALLOCATION CANCELLED','CANCELLED ALLOCATION'))
	AND CAST(A.D_DATE as date) IN (SELECT DISTINCT TOP 5 CAST(D_DATE as date) FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] ORDER BY CAST(D_DATE as date) DESC);



/* TCA Execution Fill Data 'File'
This query retrieves the individual Fills for Trade Orders from the Bloomberg EMSI (executions) data.

Notes: 
The subqueries for both OrderSize, TraderSize and BrokerSize are required to aggregate order amounts from different audit events from the Allocation event.
The use of 'magic numbers' transforms for I_IDENTTYPE and C_REASONCODE are required as no reference table for these exists, though could be created.

Need to replace the following with good data sources 
	#tmpIDs			- CUSIP data source
	#dbo.SecMaster	- Security master
*/

	DELETE FROM [TCA].[EMSX_Trade_Fill_Output];

	INSERT INTO [TCA].[EMSX_Trade_Fill_Output]
	(DecisionDateTime,
	OrderId,
	OrderStartDateTime,
	OrderSize,
	ReleaseId,
	ReleaseDateTime,
	TraderBlockId,
	TraderDateTime,
	TraderSize,
	BrokerBlockId,
	BrokerId,
	BrokerDateTime,
	BrokerSize,
	TransactionSequence,
	Symbol,
	SymbolType,
	Side,
	Shares,
	TradeDateTime,
	Price,
	Trader,
	Exchange,
	Country,
	UDMPMLIMITPRICE,
	UDMSTRATEGY,
	UDMPMINSTRUCTIONS,
	UDMPMORDERREASON,
	UDMBROKERVENUE,
	UDMBROKERORDERTYPE,
	ALGONAME,
	LASTLIQUIDITYIND,
	LASTCAPACITY,
	AggregatedTo,
	AggregatedFrom,
	Instructions,
	TIF,
	SEDOL,
	Order_Type,
	PM_Name,
	Exec_Brkr,
	Route_Instructions,
	Tran_Limit_Price,
	Tran_Account,
	Tran_Handling_Instruction,
	Tran_Exec_Instruction,
	CFD_Flag,
	Exec_Seq_Number,
	Exec_Prev_Seq_Number)
	SELECT
		DecisionDateTime = ISNULL(T.DecisionDateTime, T.[AggregatedDateTime]),
		OrderId = T.OrderNumber,
		OrderStartDateTime = ISNULL(T.OrderStartDateTime, T.[AggregatedDateTime]),
		OrderSize = A.[Amount],
		ReleaseId = ISNULL(T.Trader, 'T') + '_' + ISNULL(A.[Broker], 'B') + '_' + CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 112) + REPLACE(CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 108), ':', '_'),
		ReleaseDateTime = ISNULL(T.ReleaseDateTime, T.[AggregatedDateTime]),
		TraderBlockId = ISNULL(T.AIM_MasterTicketId, 0),
		TraderDateTime = ISNULL(T.TraderDateTime, T.[AggregatedDateTime]),
		TraderSize =  A.[Amount],
		BrokerBlockId = ISNULL(A.[Broker], 'B') + '_' + CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 112) + REPLACE(CONVERT(CHAR(8),ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]), 108), ':', '_'),
		BrokerId = A.[Broker],
		BrokerDateTime = ISNULL(T.BrokerDateTime, T.[AggregatedDateTime]),
		BrokerSize = A.[Routed_Amount],
		TransactionSequence = A.[Exec_Seq_Number],
		[Symbol] = A.ISIN, 
		[SymbolType] = 'ISIN',
		[Side] = A.SIDE, 
		[Shares] = A.[Exec_Last_Fill],
		[TradeDateTime] =  CONVERT(DATETIME, CONVERT(CHAR(8), A.[Exec_As_of_Date], 112) + ' ' + CONVERT(CHAR(8), A.[Exec_As_of_Time], 108)),
		[Price] = A.[Exec_Last_Fill_Px],
		[Trader] = A.[Trader_Name],
		[Exchange] = A.Exchange,
		[Country] = ISNULL(S.ISSUE_COUNTRY_ISO, 'US'),
		[UDMPMLIMITPRICE] = A.[Limit_Price], 
		[UDMSTRATEGY] = A.[Strategy_Type],
		[UDMPMINSTRUCTIONS] = A.[Route_Instructions],
		[UDMPMORDERREASON] = A.[Tran_Reason_Code],
		UDMBROKERVENUE = A.[LAST_MARKET],
		UDMBROKERORDERTYPE = A.[Tran_Type],
		ALGONAME = A.[Strategy_Type],
		LASTLIQUIDITYIND = A.Liquidity,
		LASTCAPACITY = A.LastCapacity,
		--ExecType = A.[Exec Type],
		AggregatedTo = ISNULL(T.AggregatedTo, ''),
		AggregatedFrom = ISNULL(T.AggregatedFrom, '')
		, A.[Instructions]
		, A.[TIF]
		, A.[SEDOL]
		, A.[Order_Type]
--    , A.[Limit Price]
--    , A.[Stop Price]
		, A.[PM_Name]
		, A.[Exec_Brkr]
		, A.[Route_Instructions]
		, A.[Tran_Limit_Price]
		, A.[Tran_Account]
		, A.[Tran_Handling_Instruction]
		, A.[Tran_Exec_Instruction]
		, A.[CFD_Flag]
		, A.[Exec_Seq_Number]
		, A.[Exec_Prev_Seq_Number]
	FROM 
		[dbo].[T_BBG_TCA_EMSX_TRADE_FILLS] A
	INNER JOIN
		@TradeEventTimeStamps	T ON A.[Order_Number] = T.OrderNumber
	LEFT OUTER JOIN 
		dbo.T_MASTER_SEC				S ON A.ISIN = S.ISIN
	WHERE
		A.[Exec_Type] <> 'CANCEL'
	AND CAST(A.EXEC_AS_OF_DATE as date) IN (SELECT DISTINCT TOP 5 CAST(D_DATE as date) FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT] ORDER BY CAST(D_DATE as date) DESC);

END TRY
BEGIN CATCH
		Declare   @ErrorMessage		NVARCHAR(4000)
				, @ErrorSeverity	INT 
				, @ErrorState		INT
				, @ErrorNumber		INT
				;

		Select	  @ErrorNumber		= ERROR_NUMBER()
				, @ErrorMessage		= @strProcedureName + ' - ' + ERROR_MESSAGE() 
				, @ErrorSeverity	= ERROR_SEVERITY()
				, @ErrorState		= ERROR_STATE();

		RaisError (
				  @ErrorMessage		-- Message text.
				, @ErrorSeverity	-- Severity.
				, @ErrorState		-- State.
			  );
		Return @ErrorNumber;
END CATCH;

