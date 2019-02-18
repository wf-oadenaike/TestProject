----[TCA].[usp_BETA_TCAoutput]	NULL, 
								--90,
								--'18525',
								----'17831,17841,17829,15913,15914,1126,14782,12472,17578,16488,17612,17807,17826,17723,17746,17750,16863,15826,15007,12406',
								----'12406,17578',--12472,12473,12490,12554,12555,12491,12428,12473', 
								--1


CREATE PROCEDURE [TCA].[usp_BETA_TCAoutput] (
											@startdate DATE = NULL,
											@daysforwardtogo INT = 10,
											@OrderIDs VARCHAR(1000) = NULL,
											@debug BIT = 0
											)
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
-- 13-03-2018	R.Walker	DAP-1892 Parameterise proc to provide more flexibility. 
--									 Fix corrected alloc brokerroutetime
--									 Fix Reason Codes not returning
--									 Implement and fix handling of cancellations
--									 Add Level by Level processing in the calc section 
-- 03-04-2018	R.Walker	DAP-1901 Revise RC code derivation for RTs. Derive RC codes from ref table
-- 02-05-2018	R.Walker	DAP-1919 Make sure allocations that happen > 10 days after the activation are included + remove 'OPSTRAN' Broker records 
-- 06-05-2018	R.Walker	DAP-2005 Weighted commissions / filter out unquoted securities / modify population of Shares_By_Account	
-- 22-05-2018	R.Walker	DAP-2056 Add in orders where there are allocations on the child order but the parent is now out of scope for processing	
-- 24-05-2018	R.Walker	DAP-2056 (v2) If traded in US, the commissions are calculated using the volume of shares traded * rate (and not price)
-- 25-05-2018	R.Walker	DAP-2056 (v3) Calculate the Broker & Sales Commission rate because BBG round the rate value to 4 d.p.s and in some instances it should be at least 5
-- 11-06-2018	R.Walker	DAP-2087 Fix Broker Commissions where they aren't UK or US transactions		
-- 25-06-2018	R.Walker	DAP-2141 Incorrect Trade Date Times being displayed for Allocations that have had a correction
-- 28-09-2018	R.Walker	DAP-2351 Take C_TRADER instead of C_USER
-- 28-09-2018	R.Walker	DAP-2350 Take the F_PRICE of the allocation rather than the weighted avg price
-- 16-10-2018	R.Walker	DAP-2378 TCA - Special dividend trades - redo the derivation of Divi and Special Divi values			
-------------------------------------------------------------------------------------- 
AS
set nocount on 
set ansi_warnings on

-- clear out existing record set
TRUNCATE TABLE TCA.BETA_TCAOutputresults

-- run it manually from here by uncommenting the variables, passing in the values you need then stepping over the data
											--DECLARE @startdate DATE = NULL
											--DECLARE @daysforwardtogo INT = 90
											--DECLARE @OrderIDs VARCHAR(1000) = '12406'
											--DECLARE @debug BIT = 0


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
	,Shares_By_Account													Varchar(50)
	,CADIS_SYSTEM_INSERTED												Datetime
	)

-------------------------------------------------------
-- get all base orders within a particulr date range

-- base orders are those with an ACTIVATED ORDER event
-------------------------------------------------------
-- This bit puts the comma separated array of OrderIds into a temp table
DECLARE @xml AS XML

SET @xml = cast(('<X>'+replace(@OrderIDs,',' ,'</X><X>')+'</X>') AS XML)

SELECT t.value('.', 'int') AS OrderIDs INTO #OrderIds
FROM @xml.nodes('/X') AS x(t)


SET @startdate = ISNULL(@startdate, DATEADD(dd, -1 * @daysforwardtogo,  GetDate()))
-- declare @startdate date = '01-JAN-2017'
-- declare @daysforwardtogo INT = 90

select   [I_TSORDNUM],[C_EVENT],[C_ACCOUNT],[C_BROKER],[F_QUANTITY],[F_PRICE],[C_CURRENCY],[C_REASONCODE],[I_AGGRFROM],[I_AGGRTO],[C_LINKFROM]
		,[D_DATE],[T_TIME],[I_CXLNUM],[I_TKTNUM],[C_TRADER],[C_USER],[C_IDENTIFIER],[I_IDENTTYPE],[C_SIDE],[C_ORDEREXCH],[C_STRATEGY_CODE],[C_INSTR],[C_SCOM_VALUE] AS [C_SCOM]
		,[C_BCOM_VALUE] AS [C_BCOM],[C_EFEE],[C_WTAX],[C_TTAX],[C_SDTY],[C_MFEE],[C_LONG1],[C_LONG2],[C_LONG3],[C_LONG4],[C_SECURITY]
		,IIF(C_CURRENCY = 'USD', IIF(F_QUANTITY = 0, 0, ABS(ROUND((C_SCOM_VALUE / F_QUANTITY),6))), IIF(F_PRINCIPAL = 0, 0, ABS(ROUND((C_SCOM_VALUE / F_PRINCIPAL),6)))) AS C_SCOM_RATE
		,IIF(C_CURRENCY = 'USD', IIF(F_QUANTITY = 0, 0, ABS(ROUND((C_BCOM_VALUE / F_QUANTITY),6))), IIF(F_PRINCIPAL = 0, 0, ABS(ROUND((C_BCOM_VALUE / F_PRINCIPAL),6)))) AS C_BCOM_RATE
-- Rounding issues in BBG Commission Rates i.e. 18143 raw data has a commission rate of 0.0003 yet on the terminal it's 0.00025. This is causing calculation errors later on so calc the rate
-- using Raw Broker Commission Value divided by the Traded Total * Weighted Price (if non US trade). Can't use the raw BBG data in all instances because of DAP-2005
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
					, 'EXECUTION OCCURRED'                    
					, 'CORRECTED ALLOCATION'
                    , 'CXL/COR MASTER TICKET'
                    , 'UPD MASTER W/ ALLOC CHANGES'
					, 'POSTTRAD ALLOC CXL/COR')
AND [I_TSORDNUM] IS NOT NULL
-- apply performance index
CREATE NONCLUSTERED INDEX [filteredorderinfo_C_EVENT]
ON [dbo].[#filteredorderinfo] ([C_EVENT])
INCLUDE ([I_TSORDNUM],[C_ACCOUNT],[F_QUANTITY],[F_PRICE],[C_CURRENCY],[C_REASONCODE])

CREATE NONCLUSTERED INDEX [filteredorderinfo_I_AGGRTO]
ON [dbo].[#filteredorderinfo] ([I_AGGRTO])
INCLUDE ([I_TSORDNUM],[C_ACCOUNT],[C_EVENT],[F_QUANTITY])
;

DECLARE @SQL AS NVARCHAR(MAX)
SET @SQL = 'INSERT INTO #orderstoprocess (i_TSORDNUM)
select distinct 
	i_TSORDNUM 
from 
	#filteredorderinfo 
where c_Event IN (''ACTIVATED ORDER'',''ORDER ALLOCATED'') ' + IIF(@OrderIDs IS NOT NULL, '
	AND i_TSORDNUM IN (SELECT OrderIDs FROM #OrderIds)', '')  
 + IIF(@OrderIDs IS NULL, '
	AND D_DATE BETWEEN ''' + CAST(@startdate AS VARCHAR) + ''' AND dateadd(dd,  ' + CAST(@daysforwardtogo AS VARCHAR) + ', ''' + CAST(@startdate AS VARCHAR) + ''')','') + '
ORDER BY 1'

CREATE TABLE #orderstoprocess (i_TSORDNUM INT)
EXEC(@SQL)

---------------------------------------------
-- Add in all parent records where we have 
-- allocations on a child order and the parent 
-- orders are no longer in scope of the 10 day period
--------------------------------------------- 
;WITH ParentOrders
	(Level
	,OrderID
	,AGGRTo
	)

AS
(
-- anchor definition

select distinct 0 AS Level,I_TSORDNUM, NULL from  #filteredorderinfo root
where I_TSORDNUM IN (SELECT I_TSORDNUM FROM #orderstoprocess)
and c_account is not null

UNION ALL

select Level - 1,I_TSORDNUM, I_AGGRTO from  #filteredorderinfo branch
INNER JOIN ParentOrders root
ON root.OrderID = branch.I_AGGRTo
	AND branch.I_AGGRTO <> branch.I_TSORDNUM 
)

INSERT INTO #orderstoprocess (i_TSORDNUM)

SELECT DISTINCT OrderID FROM ParentOrders p 
LEFT OUTER JOIN #orderstoprocess o ON 
p.OrderID = o.I_TSORDNUM 
WHERE o.I_TSORDNUM IS NULL 
	AND Level < 0

set ansi_warnings off
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
and IS_SPLIT = 'NO' ORDER BY 1 ) -- REMOVE ONCE WE CAN HANDLE SPLITS

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
	(AggLevel
	,AllocLevel
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
	,f_price
	,c_reasoncode
	,c_scom_rate
	,c_bcom_rate
	,c_currency)
AS
(
-- base level
select	 tree.Level AS AggLevel
		,1 AS AllocLevel 
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
		,C_REASONCODE
		,C_SCOM_RATE
		,C_BCOM_RATE
		,C_CURRENCY
from #filteredorderinfo root
INNER JOIN (select distinct orderID, level from #fulltree) tree
ON root.i_tsordnum = tree.orderID
and c_event = 'ORDER ALLOCATED'

-- recurrance level
UNION ALL
SELECT	 root.AggLevel
		,AllocLevel + 1 AS AllocLevel 
		,branch.I_TSORDNUM
		,branch.C_ACCOUNT
		,branch.C_BROKER
		,root.baseticket
		,branch.C_EVENT
		,root.D_DATE
		,root.T_TIME 
		,branch.I_CXLNUM
		,branch.I_TKTNUM
		,branch.F_QUANTITY
		,branch.F_PRICE
		,branch.C_REASONCODE
		,branch.C_SCOM_RATE
		,branch.C_BCOM_RATE
		,branch.C_CURRENCY
from #filteredorderinfo branch
	inner join allocationtree root
	on root.OrderID = branch.I_TSORDNUM
	and ((root.i_tktnum = branch.i_tktnum and branch.c_event = 'ALLOCATION CANCELLED' and root.c_event <> 'ALLOCATION CANCELLED')
	or (root.i_tktnum = branch.i_cxlnum and branch.c_event IN ('CORRECTED ALLOCATION','POSTTRAD ALLOC CXL/COR')))
)

-- put the contents of the CTW above into a temp table as we need to aggregate at different levels (i.e. [order, account] AND [order, account, broker])
select
	 fulldata.AggLevel 
	,fulldata.orderID
	,fulldata.account
	,fulldata.broker
	,fulldata.f_quantity
	,fulldata.f_price
	,fulldata.f_quantity * fulldata.f_price as Spend
	,SUM(fulldata.f_quantity * fulldata.f_price) OVER (PARTITION BY fulldata.orderID, fulldata.account, fulldata.broker) / SUM(fulldata.f_quantity) OVER (PARTITION BY fulldata.orderID, fulldata.account, fulldata.broker) AS WAPrice
	,fulldata.c_event
	,fulldata.d_date
	,fulldata.t_time
	,fulldata.f_quantity / SUM(fulldata.f_quantity) OVER (PARTITION BY fulldata.orderID, fulldata.account) AS BrokerRatio
	,fulldata.C_REASONCODE
	,fulldata.C_SCOM_RATE
	,fulldata.C_BCOM_RATE
	,fulldata.C_CURRENCY
INTO #fulldataWAPrice
from allocationtree fulldata
inner join
(select baseticket, MAX(AllocLevel) as maxlevel from allocationtree group by baseticket) toplevelallocs
on fulldata.baseticket = toplevelallocs.baseticket and fulldata.AllocLevel = toplevelallocs.maxlevel
where fulldata.c_event <> 'ALLOCATION CANCELLED'

select
	 AggLevel
	,orderId
	,account AS c_account
	,SUM(f_quantity) AS TotalPurchases
	,MAX(CONVERT(varchar(20),CAST(d_date AS DateTime) + CAST(T_TIME AS Datetime),20)) As LastAllocationTime
INTO #temppurchasesaggregated
FROM #fulldataWAPrice 
group by orderID, account, AggLevel


--- ********** end newfangled section

select distinct toe.level, toe.orderID, toe.aggrto, toe.c_account, tpa.totalpurchases, tpa.lastallocationtime 
into #temporderspurchasesaggregated 
from #temporders toe
left join #temppurchasesaggregated tpa
on toe.orderID = tpa.orderID
and toe.c_account = tpa.c_account

select orderID, aggrto, c_account, CAST(orderID as Varchar) + '_' + C_Account as OrderAccount, OriginalOrderQty, TotalOriginalOrderQuantity into #tempordersextended 
from #temporders where I_AGGRFROM IS NULL and OriginalOrderQty is not null

;
WITH ExplodedOrders
	(
	 level
	,OrderID
	,AggrTo
	,Account
	,OrderID_Account
	,OriginalOrderQty
	,TotalOriginalOrderQuantity
	,Inputresidual
	,PurchaseAmount
	,PurchaseRatio
	,RatioedPurchases
	,OutputResidal
	,LastAllocationTime
	)
AS
(
select 
	 tpa.level
	,toe.orderID
	,toe.aggrto
	,toe.c_account
	,toe.OrderAccount
	,toe.OriginalOrderQty
	,toe.TotalOriginalOrderQuantity
	,CAST(toe.originalorderqty As decimal(28,15))
	,tpa.totalpurchases
	,CAST(IIF(toe.orderID = @rootorderid, 1.0000, NULL) AS decimal(28,15)) AS Ratio
	,tpa.totalpurchases  As RatioedPurchases
	,CAST(toe.originalorderqty -  ISNULL(tpa.totalpurchases,0)  AS decimal(28,15)) 
	,tpa.lastallocationtime
from #tempordersextended toe
left join #temporderspurchasesaggregated tpa
on toe.orderID = tpa.orderID
and toe.c_account = tpa.c_account

union all

select
	 x.level 
	,x.orderID
	,x.aggrto
	,x.c_account
	,ExplodedOrders.OrderID_Account
	,ExplodedOrders.OriginalOrderQty
	,ExplodedOrders.TotalOriginalOrderQuantity
	,NULL
	,x.totalpurchases
	,NULL
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
	PRINT @rootorderid
			-- control which levels get populated during the iterative calculation process
			DECLARE @level AS INT
			SELECT @level = MIN(level) FROM #tempexplodedorders where outputresidal is null
-- transfer the individual input residuals
update root
set inputresidual = lowerlevel.outputresidal
from #tempexplodedorders root
inner join
(select orderID, aggrTo, orderID_Account, SUM(OutputResidal) AS OutputResidal
from #tempexplodedorders where outputresidal is not null
group by aggrTo, account, orderID, orderID_Account) lowerlevel
on root.orderID = lowerlevel.aggrto and root.orderID_account = lowerlevel.orderID_Account
WHERE root.level = @level

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
WHERE root.level = @level

-- perform the ratio calculations and ratio the purchases, then calculate the output residual

update #tempexplodedorders 
set purchaseratio = CAST(inputresidual AS DECIMAL(28,20)) / CAST(ISNULL(NULLIF(totalresidual, 0),1) AS DECIMAL(28,20)) -- avoid division by 0
, ratioedpurchases = ISNULL(purchaseamount,0) * (inputresidual / ISNULL(NULLIF(totalresidual, 0),1))
, OutputResidal = inputresidual - (ISNULL(purchaseamount,0) * (inputresidual / ISNULL(NULLIF(totalresidual, 0),1)))
where purchaseratio is null 
	and totalresidual is not null
	and level = @level

-- end of current level calc - increment level
SET @level = @level + 1
-- repeat as long as there are fields where purchaseratio is null

IF NOT EXISTS (Select 1 from #tempexplodedorders where outputresidal is  null) OR @level IS NULL
	BREAK;


END
END

-- Now split out the results by broker by applying broker weighing 
select  acc.level, 
		acc.OrderID, 
		acc.AggrTo, 
		acc.Account,
		brkr.Broker, 
		acc.OrderID_Account, 
		acc.OriginalOrderQty, 
		acc.TotalOriginalOrderQuantity, 
		acc.Inputresidual,
		acc.PurchaseAmount AS PurchaseAmountAcc, 
		acc.PurchaseAmount * brkr.BrokerRatio AS PurchaseAmount, 
		acc.PurchaseRatio, 
		acc.RatioedPurchases AS RatioedPurchasesAcc,
		(acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio AS RatioedPurchases, 
		brkr.f_price AS PurchasePrice,
		acc.OutputResidal, 
		CONVERT(varchar(20),CAST(brkr.d_date AS DateTime) + CAST(brkr.T_TIME AS Datetime),20) AS LastAllocationTime, 
		acc.TotalResidual,
		brkr.C_REASONCODE,
		CASE	WHEN brkr.C_CURRENCY = 'USD' THEN brkr.C_SCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio						-- calculated weighted commission value using the rate multiplied by weighted traded volume
				WHEN brkr.C_CURRENCY = 'GBP' THEN brkr.C_SCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio * brkr.f_price / 100	-- and weighted price (if it's a non US trade)
				ELSE brkr.C_SCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio * brkr.f_price 
		END AS C_SCOM,
		CASE	WHEN brkr.C_CURRENCY = 'USD' THEN brkr.C_BCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio						-- calculated weighted commission value using the rate multiplied by weighted traded volume		
				WHEN brkr.C_CURRENCY = 'GBP' THEN brkr.C_BCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio * brkr.f_price / 100	-- and weighted price (if it's a non US trade)
				ELSE brkr.C_BCOM_RATE * (acc.PurchaseAmount * brkr.BrokerRatio) * acc.PurchaseRatio * brkr.f_price 
		END AS C_BCOM						
INTO  #tempexplodedordersfinal
FROM #tempexplodedorders acc
LEFT OUTER JOIN #fulldataWAPrice brkr
ON acc.OrderID = brkr.OrderID
	AND acc.Account = brkr.Account


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
				,TSOXSentToBrokerDateTime
				,correction.senttobrokerdatetime)						as 'BrokerRouteTime'
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
	,cmpapprv.TraderDateTime											as 'TraderDateTime'
	,results.inputresidual												as 'TraderSize'
	,results.BROKER														as 'BrokerID'
	,COALESCE(senttobroker.senttobrokerdatetime
				,PseudoSentToBrokerDateTime
				,TSOXSentToBrokerDateTime	
				,correction.senttobrokerdatetime)						as 'BrokerDateTime'
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
	,ROUND(results.RatioedPurchases,0)									as 'Shares'
	,CONVERT(varchar(20),CAST(results.lastallocationtime AS datetime), 20)											as 'AllocationDateTime'
	,ISNULL(CAST(results.purchasePrice as Varchar),'')					as 'Price'
	,results.Account													as 'Account'
	,ISNULL(trdr.C_USER, allocated.C_USER)								as 'Trader'		-- DAP-2351
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
	,reason.Description													as 'UDMPMORDERREASON'
	,''																	as 'UDMTRADEDESK'
	,''																	as 'UDMPROGRAMID'
	,results.orderID_Account											as 'TRADEID'
	,ROUND(results.c_scom, 2)											as 'SalesCommission'
	,ROUND(results.c_bcom, 2)											as 'BrokerCommission'
	,allocated.C_EFEE													as 'ExchangeFee'
	,allocated.C_WTAX													as 'WithholdingTax'
	,allocated.C_TTAX													as 'TransferTax'
	,allocated.C_SDTY													as 'StampDuty'
	,allocated.C_MFEE													as 'MiscellaneousFee'
	,allocated.C_LONG1													as 'Dividend'
	,allocated.C_LONG2 													as 'DividendCCY'
	,allocated.C_LONG3 													as 'SpecialDividend'
	,allocated.C_LONG4 													as 'SpecialDividendCCY'
	,''																	as 'Note1'
	,''																	as 'Note2'
	,''																	as 'Note3'
	,allocated.C_EVENT													as 'C_EVENT'
	,results.AggrTo														as 'AggregatedTo'
	,results.AggrTo														as 'AggregatedFrom' -- CHANGE THIS
	,allocated.C_SECURITY												as 'C_SECURITY'
	,reason.Description													as 'REASONCODE'
	,results.OriginalOrderQty											as 'Shares_By_Account'
	,GETDATE()															as 'CADIS_SYSTEM_INSERTED'
FROM #tempexplodedordersfinal results
cross join                                                                                                                                                                                                                                                                                                         
(select top 1 T_TIME, D_DATE  from #filteredorderinfo where I_TSORDNUM = @rootorderID
and c_event = 'ACTIVATED ORDER') activated
cross join
(select top 1 * from #filteredorderinfo where I_TSORDNUM IN (select distinct orderID from #temporderspurchasesaggregated) 
and c_event IN ('ORDER ALLOCATED', 'CORRECTED ALLOCATION', 'CXL/COR MASTER TICKET', 'UPD MASTER W/ ALLOC CHANGES', 'POSTTRAD ALLOC CXL/COR') order by I_TSORDNUM, I_TKTNUM DESC) allocated
cross join
(select top 1 D_DATE, T_TIME from 
	T_BBG_TCA_TRADE_ORDERS_AUDIT
where I_TSORDNUM = @rootorderID
and (c_event =  'SELL ORDER PRE ALLOCATED' or C_EVENT = 'BUY ORDER PRE ALLOCATED')
order by D_date, T_TIME  asc) decisiondatetime
LEFT OUTER JOIN dbo.T_BBG_ReasonCode reason
ON results.C_REASONCODE = reason.code
LEFT OUTER JOIN 
(SELECT 
    I_TSORDNUM,
    CONVERT(VARCHAR, MIN(CONVERT(DATETIME, CONVERT(CHAR(8), D_DATE, 112) + ' ' + CONVERT(CHAR(8), T_TIME, 108))), 120) AS TraderDateTime
FROM [dbo].[T_BBG_TCA_TRADE_ORDERS_AUDIT]    
WHERE  C_EVENT IN ('CHANGED ASGND TRDR', 'COMPLIANCE STATUS: APPROVED', 'COMPLIANCE STATUS: PASSED')
GROUP BY I_TSORDNUM) cmpapprv
ON results.orderID = cmpapprv.I_TSORDNUM
LEFT OUTER JOIN
(select x.I_TSORDNUM, x.C_BROKER, MIN(CONVERT(varchar(20),CAST(x.d_date AS DateTime)
		+ CAST(x.T_TIME AS Datetime),20)) As SentToBrokerDateTime FROM
(SELECT * FROM #filteredorderinfo WHERE I_TSORDNUM IN(select distinct orderID from #temporderspurchasesaggregated)
AND (c_event = 'E-SENT: ROUTED TO ELEC BRKR'
	or c_event = 'M-WORK: ROUTED TO MANU BRKR')) x
GROUP BY x.I_TSORDNUM,x.C_BROKER) SentToBroker
ON results.Broker = SentToBroker.C_BROKER
AND results.orderID = SentToBroker.I_TSORDNUM
LEFT OUTER JOIN
(SELECT base.I_TSORDNUM, correction.C_BROKER, MIN(CONVERT(varchar(20),CAST(base.d_date AS DateTime)
		+ CAST(base.T_TIME AS Datetime),20)) AS SentToBrokerDateTime 
FROM #filteredorderinfo base 
INNER JOIN #filteredorderinfo correction ON base.I_TSORDNUM = correction.I_TSORDNUM 
	AND base.C_EVENT = 'ORDER ALLOCATED' 
	AND correction.C_EVENT = 'CORRECTED ALLOCATION'
GROUP BY base.I_TSORDNUM, 
		 correction.C_BROKER) correction
ON results.Broker = correction.C_BROKER
AND results.orderID = correction.I_TSORDNUM
CROSS JOIN
(
select MIN(
	CONVERT(varchar(20),CAST(x.d_date AS DateTime)
		+ CAST(x.T_TIME AS Datetime),20)) As PseudoSentToBrokerDateTime FROM
(SELECT * FROM #filteredorderinfo WHERE I_TSORDNUM IN
	(select distinct orderID from #temporderspurchasesaggregated)
AND (c_event IN ('E-WORK: ELEC BRKR ACKED','M-WORK: ROUTED TO MANU BRKR'))) x
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
LEFT OUTER JOIN 
(select TOP 1 C_USER from T_BBG_TCA_TRADE_ORDERS_AUDIT where C_EVENT IN ('E-FILL: ELEC FILL OCCURRED', 'E-PFIL: ELEC PARTFILL OCCURRED', 'M-FILL: MANU FILL OCCURRED', 'M-PFIL: MANU PARTFILL OCCURRED', 'AGGREGATED FROM', 'AGGREGATED TO') AND I_TSORDNUM IN (select distinct orderID from #temporderspurchasesaggregated) order by I_TSORDNUM, I_TKTNUM DESC) trdr
ON 1 = 1
where LEFT(results.orderID_Account, CHARINDEX ( '_' ,results.orderID_Account ) - 1) = CAST(@rootorderID AS Varchar)




UPDATE #orderstoprocessextended SET PROCESSED = 1 WHERE ORDER_ID = @rootorderid

-- populate the output table
INSERT INTO TCA.BETA_TCAOutputresults
SELECT * FROM #outputresults
WHERE BrokerID NOT IN ('OPSTRAN', 'TEST', 'SPLIT', 'DIRECT', 'TESTBCEQ')  -- remove OPSTRAN records as these are failed order allocations 
	AND LEFT(C_SECURITY,1) <> '.'	-- remove unquoted
order by parentorderid, orderid, FIRSTFILL 

TRUNCATE TABLE #outputresults
-- tidy up the various temp tables I've created
IF @Debug = 1
BEGIN
	SELECT '#temptree'
	SELECT * FROM #temptree
	SELECT '#fulltree'
	SELECT * FROM #fulltree
	SELECT '#temporders'
	SELECT * FROM #temporders
	SELECT '#temppurchasesaggregated'
	SELECT * FROM #temppurchasesaggregated
	SELECT '#temporderspurchasesaggregated'
	SELECT * FROM #temporderspurchasesaggregated
	SELECT '#tempordersextended'
	SELECT * FROM #tempordersextended
	SELECT '#tempexplodedorders'
	SELECT * FROM #tempexplodedorders
	SELECT '#tempexplodedordersfinal'
	SELECT * FROM #tempexplodedordersfinal
	SELECT '#fulldataWAPrice'
	SELECT * FROM #fulldataWAPrice
END 	

DROP TABLE #temptree
DROP TABLE #fulltree
DROP TABLE #temporders
DROP TABLE #temppurchasesaggregated
DROP TABLE #temporderspurchasesaggregated
DROP TABLE #tempordersextended
DROP TABLE #tempexplodedorders 
DROP TABLE #tempexplodedordersfinal
DROP TABLE #fulldataWAPrice
--DROP TABLE #tempcancellations
--DROP TABLE #tempcancellationsaggregated 


END  --- of the outer loop
;



/* -- uncomment this bit, and comment out the next bit,
--  if you want to put the results into the table for processing in the flow */





/* -- if you run this bit, the results will just get output to your screen, or to a file
-- if you have 'results to file' set.  You probably wnat this if you are doing historical catchup 
-- files 



SELECT * FROM #outputresults 
order by parentorderid, orderid, FIRSTFILL */















