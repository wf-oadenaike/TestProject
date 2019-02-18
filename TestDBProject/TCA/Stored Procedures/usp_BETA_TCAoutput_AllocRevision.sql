






CREATE PROCEDURE [TCA].[usp_BETA_TCAoutput_AllocRevision]
-------------------------------------------------------------------------------------- 
-- Name:			[TCA].[usp_BETA_TCAoutput]
-- 
-- Note:			Release 1.0 - more work scheduled to be done - tickets exist
-- 
-- Author:			W.Stubbs
-- Date:			23/01/2018
-------------------------------------------------------------------------------------- 
-- Description:		Create the output data for the TCA deaggregated file
-- History:			
-- Initial Write 
-- 16-02-2018	W.Stubbs	DAP-1703
--							DAP-1803 Change treatment of brokerdatetime and dividends
-- 19-02-2018	W.Stubbs	DAP-1806 Change treatment of brokerdatetime 
-- 20-02-2018	W.Stubbs	DAP-1784 Change decisiondatetime source
-- 21-02-2018	W.Stubbs	DAP-1812 Change calculation and format of broker and sales commissions
-- 08-03-2018	W.Stubbs	DAP-1840 Ensure brokerdatetime in corner case when order not routed
-- 09-03-2018	W.Stubbs	DAP-1845 Still no brokerdatetime for TSOX trades
-------------------------------------------------------------------------------------- 
AS


set nocount on 
set ansi_warnings off


-----------------------------------------------------
-- Create the definition of the final output table
-----------------------------------------------------

CREATE TABLE #outputresults
	(
	DecisionDateTime													Varchar(50)
	,ParentOrderID														Varchar(50)
	,OrderID															Varchar(50)
	,BrokerRouteTime													Varchar(50)
	,FirstFill															Varchar(50)
	,TotalOrderSize														Varchar(50)
	,BrokerReleaseSize													Varchar(50)
	,OrderSize															Varchar(50)
	,ReleaseID															Varchar(50)
	,ReleaseDateTime													Varchar(50)
	,TraderBlockID														Varchar(50)
	,TraderDateTime														Varchar(50)
	,TraderSize															Varchar(50)
	,BrokerID															Varchar(50)
	,BrokerDateTime														Varchar(50)
	,Symbol																Varchar(50)
	,SymbolType															Varchar(50)
	,Side																Varchar(50)
	,Shares																Varchar(50)
	,AllocationDateTime													Varchar(50)
	,Price																Varchar(50)
	,Account															Varchar(50)
	,Trader																Varchar(50)
	,Exchange															Varchar(50)
	,Country															Varchar(50)
	,Currency															Varchar(50)
	,UDMFUND															Varchar(50)
	,UDMSTRATEGY														Varchar(50)
	,UDMPMINSTRUCTIONS													Varchar(50)
	,UDMPMORDERREASON													Varchar(50)
	,UDMTRADEDESK														Varchar(50)
	,UDMPROGRAMID														Varchar(50)
	,TRADEID															Varchar(50)
	,SalesCommission													Varchar(50)
	,BrokerCommission													Varchar(50)
	,ExchangeFee														Varchar(50)
	,WithholdingTax														Varchar(50)
	,TransferTax														Varchar(50)
	,StampDuty															Varchar(50)
	,MiscellaneousFee													Varchar(50)
	,Dividend															Varchar(50)
	,DividendCCY														Varchar(50)
	,SpecialDividend													Varchar(50)
	,SpecialDividendCCY													Varchar(50)
	,Note1																Varchar(50)
	,Note2																Varchar(50)
	,Note3																Varchar(50)
	,C_EVENT															Varchar(50)
	,AggregatedTo														Varchar(50)
	,AggregatedFrom														Varchar(50)
	,C_SECURITY															Varchar(50)
	,REASONCODE															Varchar(50)
	)

-------------------------------------------------------
-- get all base orders within a particulr date range

-- base orders are those with an ACTIVATED ORDER event
-------------------------------------------------------

--
-- DATE CHANGE HERE
--


declare @startdate date = DATEADD(dd, -10,  GetDate())
--declare @startdate date = '01-JAN-2017'
declare @daysforwardtogo int = 90

select *
into #filteredorderinfo 
from T_BBG_TCA_TRADE_ORDERS_AUDIT
where c_event in ('ACTIVATED ORDER'
					, 'ORDER ALLOCATED'
					, 'AGGREGATED FROM'
					, 'AGGREGATED TO'
					, 'E-SENT: ROUTED TO ELEC BRKR'
					, 'ALLOCATION CANCELLED'
					, 'M-WORK: ROUTED TO MANU BRKR'
					, 'E-WORK: ELEC BRKR ACKED'
					, 'EXECUTION OCCURRED')

select distinct 
	i_TSORDNUM 
into 
	#orderstoprocess
from 
	#filteredorderinfo
where c_Event = 'ACTIVATED ORDER'  --and i_TSORDNUM in (16632,16642) --< this bit is a limiter to get a specific orderID
group by i_TSORDNUM
having MIN(D_DATE) BETWEEN @startdate AND dateadd(dd,  @daysforwardtogo, @startdate)

---------------------------------------------
-- identify each order and the type of order
-----------------------------------------------

select distinct root.I_TSORDNUM as ORDER_ID
	, CASE WHEN aggr.I_AGGRTO is not null then 'YES' ELSE 'NO' END AS IS_AGGR 
	, CASE WHEN ssplit.C_LINKFROM is not null then 'YES' ELSE 'NO' END AS IS_SPLIT	
	, 0 AS PROCESSED
INTO #orderstoprocessextended
from #filteredorderinfo root
left join 
	#filteredorderinfo aggr on root.I_TSORDNUM = aggr.I_TSORDNUM and aggr.I_AGGRTO is not null
left join (select I_TSORDNUM, C_LINKFROM FROM #filteredorderinfo where c_LINKFROM IS NOT NULL) ssplit 
on root.I_TSORDNUM = ssplit.c_LINKFROM  
inner join #orderstoprocess orderstoprocess
on root.I_TSORDNUM = orderstoprocess.I_TSORDNUM


---------------------------------
-- begin outer iterative process
---------------------------------

WHILE 1=1

BEGIN

IF NOT EXISTS (Select 1 from #orderstoprocessextended where PROCESSED = 0
and IS_SPLIT = 'NO')  -- REMOVE ONCE WE CAN HANDLE SPLITS
	BREAK;

declare @rootorderID int

set @rootorderid = (select  TOP(1) ORDER_ID FROM #orderstoprocessextended where PROCESSED = 0
and IS_SPLIT = 'NO' ) -- REMOVE ONCE WE CAN HANDLE SPLITS

;

WITH OrderAllocationTrail 
	(Level
	,OrderID
	,Account
	,AGGRFrom
	)

AS
(
-- anchor definition

select distinct 0 AS Level,I_TSORDNUM, C_ACCOUNT, NULL from  #filteredorderinfo root
where I_TSORDNUM = @rootorderID
and c_account is not null

-- recurrance definition

UNION ALL

select Level + 1,I_TSORDNUM, C_ACCOUNT, I_AGGRFROM from  #filteredorderinfo branch
INNER JOIN OrderAllocationTrail root
ON root.OrderID = branch.I_AGGRFROM
	AND branch.I_AGGRFROM <> branch.I_TSORDNUM -- patch to cope with corrupt data where an order seems to aggregate to itself
--or root.OrderID = branch.C_LINKFROM



)


select y.*, z.f_quantity, Z.f_Price, z.C_CURRENCY 
 INTO #temptree 
FROM
(
select distinct root.level, root.orderiD, x.C_ACCOUNT from OrderAllocationTrail root
CROSS JOIN
(select distinct C_ACCOUNT FROM #filteredorderinfo where I_TSORDNUM = @rootorderID 
and C_EVENT = 'ACTIVATED ORDER') x

) y
left join #filteredorderinfo z
on y.OrderID = z.I_TSORDNUM
	and y.C_ACCOUNT = z.C_ACCOUNT
	and z.C_EVENT = 'ORDER ALLOCATED'


/*'TEMPTREE'*/


--------------------------------------------------------------------------------------
-- for each non level 0 entry, find out all the root entries of which it is composed
-------------------------------------------------------------------------------------


-- another recursize cte

-- actually this needs to be inside a recursive loop, because there may be multiple tops of the tree (with splits)
-- we will
-- 1) identify all tops of the tree
-- 2) loop for each top of the tree
-- 3) dedupe the results

DECLARE @topdown int = (select distinct orderID from #temptree where level = (select max(level) from #temptree))

-- anchor definition
;
with findallrootorders
	(Level
	,AggrTo
	,OrderID
	,Account
	,Amount
	,ActionType
	)

AS

(select 0 AS Level,NULL, I_TSORDNUM, C_ACCOUNT, f_quantity, c_event from  #filteredorderinfo 
where I_TSORDNUM = @topdown
and c_event = 'ORDER ALLOCATED'
UNION ALL
select Level - 1, branch.I_AGGRTO , I_TSORDNUM, C_ACCOUNT, f_quantity, c_event from  #filteredorderinfo branch
inner join findallrootorders root
on branch.I_AGGRTO = root.OrderID and branch.I_AGGRTO <> branch.I_TSORDNUM)

select distinct level, orderID, AggrTo
into #fulltree 
from findallrootorders

select allorders.*, aggrfrom.I_AGGRFROM,baseorders.F_QUANTITY AS OriginalOrderQty, aggregatedtotals.TotalOriginalOrderQuantity AS TotalOriginalOrderQuantity
into #temporders
FROM
(select #fulltree.*, x.* from #fulltree
cross join (select distinct C_ACCOUNT FROM #temptree) x) allorders
left join 
(SELECT DISTINCT I_TSORDNUM, I_AGGRFROM FROM #filteredorderinfo 
where C_EVENT = 'AGGREGATED FROM') aggrfrom
on allorders.orderID = aggrfrom.I_TSORDNUM 
left join 
#filteredorderinfo baseorders
on allorders.orderID = baseorders.I_TSORDNUM
and allorders.c_account = baseorders.C_ACCOUNT
and baseorders.C_EVENT = 'ACTIVATED ORDER'
left join
(select I_TSORDNUM, sum(F_QUANTITY) As TotalOriginalOrderQuantity FROM #filteredorderinfo 
where C_EVENT = 'ACTIVATED ORDER'
group by I_TSORDNUM) aggregatedtotals
on allorders.orderID = aggregatedtotals.I_TSORDNUM
order by orderID ASC
;
--- ********** newfangled section

with allocationtree
	(Level
	,OrderID
	,account
	,broker
	,baseticket
	,c_event
	,d_date
	,t_time
	,i_cxlnum
	,i_tktnum
	,f_quantity
	,f_price)
AS
(
-- base level
select	1 AS Level
		,I_TSORDNUM
		,C_ACCOUNT
		,C_BROKER
		,I_TKTNUM as rootallocation
		,C_EVENT
		,D_DATE
		,T_TIME 
		,I_CXLNUM
		,I_TKTNUM
		,F_QUANTITY
		,F_PRICE
from T_BBG_TCA_TRADE_ORDERS_AUDIT root
where i_tsordnum IN (select distinct orderID from #fulltree)
and c_event = 'ORDER ALLOCATED'

-- recurrance level
UNION ALL
SELECT	Level+1 
		,branch.I_TSORDNUM
		,branch.C_ACCOUNT
		,branch.C_BROKER
		,root.baseticket
		,branch.C_EVENT
		,branch.D_DATE
		,branch.T_TIME 
		,branch.I_CXLNUM
		,branch.I_TKTNUM
		,branch.F_QUANTITY
		,branch.F_PRICE
from T_BBG_TCA_TRADE_ORDERS_AUDIT branch
	inner join allocationtree root
	on root.OrderID = branch.I_TSORDNUM
	and ((root.i_tktnum = branch.i_tktnum and branch.c_event = 'ALLOCATION CANCELLED' and root.c_event <> 'ALLOCATION CANCELLED')
	or (root.i_tktnum = branch.i_cxlnum and branch.c_event IN ('CORRECTED ALLOCATION','POSTTRAD ALLOC CXL/COR')))
)

select
	x.orderId
	,x.account AS c_account
	,x.broker AS C_broker
	,SUM(x.f_quantity) As TotalPurchases
	,SUM(x.Spend) / SUM(x.f_quantity) As WAPrice
	,MAX(
		CONVERT(varchar(20),CAST(x.d_date AS DateTime)+ CAST(x.T_TIME AS Datetime),20)
		) As LastAllocationTime
INTO #temppurchasesaggregated
FROM
(select 
	fulldata.orderID
	,fulldata.account
	,fulldata.broker
	,fulldata.f_quantity
	,fulldata.f_price
	,fulldata.f_quantity * fulldata.f_price as Spend
	,fulldata.c_event
	,fulldata.d_date
	,fulldata.t_time
from allocationtree fulldata
inner join
(select baseticket, MAX(level) as maxlevel from allocationtree group by baseticket) toplevelallocs
on fulldata.baseticket = toplevelallocs.baseticket and fulldata.Level = toplevelallocs.maxlevel
where fulldata.c_event <> 'ALLOCATION CANCELLED') x
group by orderID, account, broker

--- ********** end newfangled section



/* This is old code, maintained here in case the newfangled section is faulty

select #fulltree.level, #fulltree.OrderID, x.*, purchases.C_BROKER, purchases.F_QUANTITY AS PurchaseQty, purchases.F_Price, CAST (D_DATE AS Datetime)  + CAST(T_TIME AS Datetime) AS AllocationTimestamp
into #temppurchases
from #fulltree
cross join (select distinct C_ACCOUNT FROM #temptree) x
left join #filteredorderinfo purchases
on #fulltree.orderID = purchases.I_TSORDNUM
and x.c_account = purchases.C_ACCOUNT
and purchases.C_EVENT = 'ORDER ALLOCATED'
order by level, orderID ASC

select #fulltree.level, #fulltree.OrderID, x.*, purchases.C_BROKER, purchases.F_QUANTITY AS CancellationQty
into #tempcancellations
from #fulltree
cross join (select distinct C_ACCOUNT FROM #temptree) x
left join #filteredorderinfo purchases
on #fulltree.orderID = purchases.I_TSORDNUM
and x.c_account = purchases.C_ACCOUNT
and purchases.C_EVENT = 'ALLOCATION CANCELLED'
order by level, orderID ASC

-- how much ORDERED at each level

-- how much BOUGHT at each level

select orderID, c_account, c_broker, sum(purchaseqty) as totalpurchases, sum(purchaseqty*F_price)/SUM(purchaseqty) as WAPrice, max(allocationtimestamp) as lastallocationtime
into #temppurchasesaggregated
from #temppurchases
group by orderID, c_account, c_broker

select orderID, c_account,c_broker, sum(CancellationQty) as totalcancellations
into #tempcancellationsaggregated
from #tempcancellations
group by orderID, c_account, c_broker

*/

-- code resumes here

select toe.orderID, toe.aggrto, toe.c_account, tpa.c_broker,  tpa.totalpurchases, tpa.WAPrice, tpa.lastallocationtime into #temporderspurchasesaggregated from #temporders toe
left join #temppurchasesaggregated tpa
on toe.orderID = tpa.orderID
and toe.c_account = tpa.c_account



select orderID, aggrto, c_account, CAST(orderID as Varchar) + '_' + C_Account as OrderAccount, OriginalOrderQty, TotalOriginalOrderQuantity into #tempordersextended from #temporders where I_AGGRFROM IS NULL and OriginalOrderQty is not null

;
WITH ExplodedOrders
	(
	OrderID
	,AggrTo
	,Account
	,Broker
	,OrderID_Account
	,OriginalOrderQty
	,TotalOriginalOrderQuantity
	,Inputresidual
	,PurchaseAmount
	,PurchaseRatio
	,PurchasePrice
	,RatioedPurchases
	,OutputResidal
	,LastAllocationTime
	)
AS
(
select 
	toe.orderID
	,toe.aggrto
	,toe.c_account
	,tpa.c_broker
	,toe.OrderAccount
	,toe.OriginalOrderQty
	,toe.TotalOriginalOrderQuantity
	,CAST(toe.originalorderqty As Float)
	,tpa.totalpurchases
	,1.0000 As Ratio
	,tpa.WAPrice
	,tpa.totalpurchases As RatioedPurchases
	,CAST(toe.originalorderqty -  ISNULL(tpa.totalpurchases,0)  AS Float) 
	,tpa.lastallocationtime
from #tempordersextended toe
left join #temppurchasesaggregated tpa
on toe.orderID = tpa.orderID
and toe.c_account = tpa.c_account

union all

select 
	x.orderID
	,x.aggrto
	,x.c_account
	,x.c_broker
	,ExplodedOrders.OrderID_Account
	,ExplodedOrders.OriginalOrderQty
	,ExplodedOrders.TotalOriginalOrderQuantity
	,NULL
	,x.totalpurchases
	,NULL
	,x.WAPrice
	,NULL
	,NULL
	,x.lastallocationtime

from
#temporderspurchasesaggregated x
inner join ExplodedOrders
on x.orderID = explodedorders.aggrto
and x.C_ACCOUNT = explodedorders.account

)

select distinct *, NULL AS TotalResidual into #tempexplodedorders 
from explodedorders 
order by orderID, account


-- BEGIN ITERATIVE PROCESS

IF  EXISTS (Select 1 from #tempexplodedorders where outputresidal is  null)
BEGIN
WHILE 1=1
BEGIN

-- transfer the individual input residuals
update root
set inputresidual = lowerlevel.outputresidal 
from #tempexplodedorders root
inner join
(select orderID, aggrTo, orderID_Account, OutputResidal
from #tempexplodedorders where outputresidal is not null) lowerlevel
on root.orderID = lowerlevel.aggrto and root.orderID_account = lowerlevel.orderID_Account

-- transfer the total input residuals
update root 
set 
	totalresidual = aggregates.TotalInputResidual
from #tempexplodedorders root left join
(select  aggrTo, account, SUM(OutputResidal) AS TotalInputResidual
from #tempexplodedorders where outputresidal is not null
group by aggrTo, account) aggregates
on root.orderID = aggregates.aggrto
and root.account = aggregates.account

-- perform the ratio calculations and ratio the purchases, then calculate the output residual

update #tempexplodedorders 
set purchaseratio = inputresidual / ISNULL(NULLIF(totalresidual, 0),1) -- avoid division by 0
, ratioedpurchases = ISNULL(purchaseamount,0) * (inputresidual / ISNULL(NULLIF(totalresidual, 0),1))
, OutputResidal = inputresidual - (ISNULL(purchaseamount,0) * (inputresidual / ISNULL(NULLIF(totalresidual, 0),1)))
where purchaseratio is null and totalresidual is not null

-- repeat as long as there are fields where purchaseratio is null

IF NOT EXISTS (Select 1 from #tempexplodedorders where outputresidal is  null)
	BREAK;


END
END


-- only use these results if there are any purchases anywhere in the tree

IF EXISTS(SELECT 1 FROM #tempexplodedorders WHERE RatioedPurchases <> 0)
INSERT into #outputresults 
select 
	 CONVERT(varchar(20), CAST(decisiondatetime.d_date AS Datetime) 
		+ CAST(decisiondatetime.T_TIME AS DateTime),20)					as 'DecisionDateTime'
	,@rootorderID														as 'ParentOrderID'
	,results.orderID													as 'OrderID'
	,COALESCE(senttobroker.senttobrokerdatetime
				,PseudoSentToBrokerDateTime
				,TSOXSentToBrokerDateTime)										as 'BrokerRouteTime'
	,CONVERT(varchar(20),CAST(allocated.d_date AS DateTime)
		+ CAST(allocated.T_TIME AS Datetime),20)						as 'FirstFill'
	,results.TotalOriginalOrderQuantity									as 'TotalOrderSize' 
	,results.TotalOriginalOrderQuantity									as 'BrokerReleaseSize'
	,results.OriginalOrderQty											as 'OrderSize'
	,allocated.C_USER 
		+ '_' + allocated.C_BROKER 
		+ '_' + CAST(YEAR(allocated.D_DATE) AS Varchar) + CAST(MONTH(allocated.D_DATE) AS Varchar) + CAST(DAY(allocated.D_DATE) AS Varchar)
		+ CAST(DATEPART(hh,allocated.T_TIME) AS Varchar)
		+ '_' + CAST(DATEPART(mi,allocated.T_TIME) AS Varchar) 
		+ '_' + CAST(DATEPART(ss,allocated.T_TIME) AS Varchar)															
																		as 'ReleaseID'
	,CONVERT(varchar(20),CAST(activated.D_Date As Datetime)
		+ CAST(activated.T_TIME AS DateTime),20)						as 'ReleaseDateTime'
	,results.OrderID_Account											as 'TraderBlockID'
	,CONVERT(varchar(20),CAST(activated.D_Date As Datetime)
		+ CAST(activated.T_TIME AS DateTime),20)						as 'TraderDateTime'
	,results.inputresidual												as 'TraderSize'
	,results.BROKER														as 'BrokerID'
	,COALESCE(senttobroker.senttobrokerdatetime
				,PseudoSentToBrokerDateTime
				,TSOXSentToBrokerDateTime)										as 'BrokerDateTime'
	,allocated.C_IDENTIFIER												as 'Symbol'
	,CASE allocated.I_IDENTTYPE
		WHEN 0 THEN 'UNKN'
		WHEN 1 THEN 'CUSIP'
		WHEN 2 THEN 'SEDOL2'
		WHEN 6 THEN 'WPK'
		WHEN 8 THEN 'ISIN'
		WHEN 10 THEN 'VALOREN'
		WHEN 24 THEN 'CINS'
		WHEN 25 THEN 'SEDOL1'
		WHEN 30 THEN 'BBG'
		ELSE NULL
		END																as 'SymbolType'
	,allocated.C_SIDE													as 'Side'
	,results.RatioedPurchases											as 'Shares'
	,CONVERT(varchar(20),CAST(results.lastallocationtime AS datetime), 20)											as 'AllocationDateTime'
	,ISNULL(CAST(results.purchasePrice as Varchar),'')					as 'Price'
	,results.Account													as 'Account'
	,allocated.C_USER													as 'Trader'
	,allocated.C_ORDEREXCH												as 'Exchange'
	,CASE allocated.C_ORDEREXCH
		WHEN 'DC' THEN 'DK'
		WHEN 'FP' THEN 'FR'
		WHEN 'GR' THEN 'DE'
		WHEN 'GU' THEN 'GG'
		WHEN 'GY' THEN 'DE'
		WHEN 'IB' THEN 'IN'
		WHEN 'ID' THEN 'IE'
		WHEN 'LN' THEN 'GB'
		WHEN 'LON' THEN 'GB'
		WHEN 'LX' THEN 'LU'
		WHEN 'NO' THEN 'NO'
		WHEN 'NOT' THEN 'NO'
		WHEN 'SW' THEN 'CH'
		WHEN 'US' THEN 'US'
		WHEN 'VX' THEN 'CH'
		ELSE NULL
		END																as 'Country'
	,allocated.C_CURRENCY												as 'Currency'
	,results.Account													as 'UDMFUND'
	,allocated.C_STRATEGY_CODE											as 'UDMSTRATEGY'
	,allocated.C_INSTR													as 'UDMPMINSTRUCTIONS'
	,CASE	allocated.C_ReasonCode
		WHEN 1 THEN 'CU'
		WHEN 2 THEN 'EX'
		WHEN 3 THEN 'PL'
		WHEN 4 THEN 'IP'
		WHEN 5 THEN 'CR'
		WHEN 6 THEN 'UQ'
		WHEN 7 THEN 'RT'
		WHEN 8 THEN 'BB'
		ELSE NULL
		END																as 'UDMPMORDERREASON'
	,''																	as 'UDMTRADEDESK'
	,''																	as 'UDMPROGRAMID'
	,results.orderID_Account											as 'TRADEID'
	,SUBSTRING(
	 allocated.c_scom
	,COALESCE(NULLIF(CHARINDEX('  +', allocated.c_scom),0)
	,CHARINDEX('  -', allocated.c_scom))  + 3
	,LEN(allocated.c_scom))												as 'SalesCommission'
	,SUBSTRING(
		allocated.c_bcom
		,COALESCE(NULLIF(CHARINDEX('  +', allocated.c_bcom),0)
		,CHARINDEX('  -', allocated.c_bcom)) + 3
		,LEN(allocated.c_bcom))											as 'BrokerCommission'
	,allocated.C_EFEE													as 'ExchangeFee'
	,allocated.C_WTAX													as 'WithholdingTax'
	,allocated.C_TTAX													as 'TransferTax'
	,allocated.C_SDTY													as 'StampDuty'
	,allocated.C_MFEE													as 'MiscellaneousFee'
	,CASE
		WHEN allocated.C_ReasonCode <> 1 
			THEN allocated.C_LONG1
		ELSE NULL END													as 'Dividend'
	,CASE	
		WHEN allocated.C_ReasonCode <> 1
			THEN allocated.C_LONG2
		ELSE NULL END													as 'DividendCCY'
	,CASE
		WHEN allocated.C_ReasonCode = 1
			THEN allocated.C_LONG1
		ELSE NULL END 													as 'SpecialDividend'
	,CASE
		WHEN allocated.C_ReasonCode = 1
			THEN allocated.C_LONG2
		ELSE NULL END													as 'SpecialDividendCCY'
	,''																	as 'Note1'
	,''																	as 'Note2'
	,''																	as 'Note3'
	,allocated.C_EVENT													as 'C_EVENT'
	,results.AggrTo														as 'AggregatedTo'
	,results.AggrTo														as 'AggregatedFrom' -- CHANGE THIS
	,allocated.C_SECURITY												as 'C_SECURITY'
	,CASE	allocated.C_ReasonCode
		WHEN 1 THEN 'CU'
		WHEN 2 THEN 'EX'
		WHEN 3 THEN 'PL'
		WHEN 4 THEN 'IP'
		WHEN 5 THEN 'CR'
		WHEN 6 THEN 'UQ'
		WHEN 7 THEN 'RT'
		WHEN 8 THEN 'BB'
		ELSE NULL
		END																as 'REASONCODE' -- convert via lookup?

FROM #tempexplodedorders results
cross join                                                                                                                                                                                                                                                                                                         
(select top 1 T_TIME, D_DATE  from #filteredorderinfo where I_TSORDNUM = @rootorderID
and c_event = 'ACTIVATED ORDER') activated
cross join
(select top 1 * from #filteredorderinfo where I_TSORDNUM IN (select distinct orderID from #temporderspurchasesaggregated) 
and c_event = 'ORDER ALLOCATED' order by I_TSORDNUM) allocated
cross join
(select top 1 D_DATE, T_TIME from 
	T_BBG_TCA_TRADE_ORDERS_AUDIT
where I_TSORDNUM = @rootorderID
and (c_event =  'SELL ORDER PRE ALLOCATED' or C_EVENT = 'BUY ORDER PRE ALLOCATED')
order by D_date, T_TIME  asc) decisiondatetime
LEFT OUTER JOIN
(select x.I_TSORDNUM, x.C_BROKER, MIN(CONVERT(varchar(20),CAST(x.d_date AS DateTime)
		+ CAST(x.T_TIME AS Datetime),20)) As SentToBrokerDateTime FROM
(SELECT * FROM #filteredorderinfo WHERE I_TSORDNUM IN(select distinct orderID from #temporderspurchasesaggregated)
AND (c_event = 'E-SENT: ROUTED TO ELEC BRKR'
	or c_event = 'M-WORK: ROUTED TO MANU BRKR')) x
GROUP BY x.I_TSORDNUM,x.C_BROKER) SentToBroker
ON results.Broker = SentToBroker.C_BROKER
AND results.orderID = SentToBroker.I_TSORDNUM
CROSS JOIN
(
select MIN(
	CONVERT(varchar(20),CAST(x.d_date AS DateTime)
		+ CAST(x.T_TIME AS Datetime),20)) As PseudoSentToBrokerDateTime FROM
(SELECT * FROM #filteredorderinfo WHERE I_TSORDNUM IN
	(select distinct orderID from #temporderspurchasesaggregated)
AND (c_event = 'E-WORK: ELEC BRKR ACKED')) x
) PseudoSentToBroker
CROSS JOIN
(
select MIN(
	CONVERT(varchar(20),CAST(x.d_date AS DateTime)
		+ CAST(x.T_TIME AS Datetime),20)) As TSOXSentToBrokerDateTime FROM
(SELECT * FROM #filteredorderinfo WHERE I_TSORDNUM IN
	(select distinct orderID from #temporderspurchasesaggregated)
AND (c_event = 'EXECUTION OCCURRED')) x
) TSOXSentToBroker
where LEFT(results.orderID_Account, CHARINDEX ( '_' ,results.orderID_Account ) - 1) = CAST(@rootorderID AS Varchar)




UPDATE #orderstoprocessextended SET PROCESSED = 1 WHERE ORDER_ID = @rootorderid

-- tidy up the various temp tables I've created

DROP TABLE #temptree
DROP TABLE #fulltree
DROP TABLE #temporders
--DROP TABLE #temppurchases
DROP TABLE #temppurchasesaggregated
DROP TABLE #temporderspurchasesaggregated
DROP TABLE #tempordersextended
DROP TABLE #tempexplodedorders 
--DROP TABLE #tempcancellations
--DROP TABLE #tempcancellationsaggregated 

END  --- of the outer loop
;



/* -- uncomment this bit, and comment out the next bit,
--  if you want to put the results into the table for processing in the flow */

truncate table TCA.BETA_TCAOutputresults

INSERT INTO TCA.BETA_TCAOutputresults
SELECT * FROM #outputresults 
order by parentorderid, orderid, FIRSTFILL 

/* -- if you run this bit, the results will just get output to your screen, or to a file
-- if you have 'results to file' set.  You probably wnat this if you are doing historical catchup 
-- files 



SELECT * FROM #outputresults 
order by parentorderid, orderid, FIRSTFILL */














