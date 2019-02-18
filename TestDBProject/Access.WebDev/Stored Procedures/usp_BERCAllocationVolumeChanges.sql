

CREATE PROC [Access.WebDev].[usp_BERCAllocationVolumeChanges]
-------------------------------------------------------------
------------------------- 
-- Name: [Access.WebDev].[ufn_BERCAllocationVolumeChanges]
-- Shifted from function as the Data Generator that uses it retrieves the data to slowly so caching in the DB first
-- 
-- Params:	@OrderID - Run for a specific order or everything. Default (NULL) - everything
-------------------------------------------------------------------------------------- 
-- History:
-- R. Walker: 13/07/2018 JIRA: DAP-2090 - Pre-execution change - Trades where the shares per account ratio between Activated vs Actual Allocations changed
-------------------------------------------------------------------------------------- 	
AS

  -- Find all entry point records
SELECT DISTINCT I_TSORDNUM INTO #Orders FROM "dbo"."T_BBG_TCA_TRADE_ORDERS_AUDIT" WHERE C_EVENT = 'ACTIVATED ORDER'

 -- Find inscope entries and cache them in memory
SELECT DISTINCT I_TSORDNUM, C_EVENT, C_ACCOUNT,I_AGGRFROM, I_AGGRTO, C_LINKFROM, C_LINKTO INTO #TRADE_ORDERS_AUDIT FROM "dbo"."T_BBG_TCA_TRADE_ORDERS_AUDIT" 
WHERE C_EVENT in ('ACTIVATED ORDER'
					, 'ORDER ALLOCATED'
					, 'AGGREGATED FROM'
					, 'AGGREGATED TO'
					, 'SPLIT ACCOUNT(S) FROM ORDER'
					, 'SPLIT ORDER')

CREATE INDEX IDX_CTE ON #TRADE_ORDERS_AUDIT 
(
	I_TSORDNUM
)
INCLUDE 
(
	C_EVENT,
	I_AGGRFROM,
	C_LINKFROM,
	C_ACCOUNT
)

 CREATE TABLE #OrderAllocationTrail 
		(Level TINYINT
		,OrderID INT
		,Account VARCHAR(20)
		,AGGRFrom INT)

 DECLARE @RootOrder INT
 SELECT TOP 1 @RootOrder = I_TSORDNUM FROM #Orders ORDER BY 1 ASC

 WHILE @RootOrder IS NOT NULL

 BEGIN

;WITH OrderAllocationTrail 
	(Level
	,OrderID
	,Account
	,AGGRFrom
	)

AS
(
-- anchor definition

select distinct 0 AS Level,I_TSORDNUM, C_ACCOUNT, NULL FROM #TRADE_ORDERS_AUDIT WHERE I_TSORDNUM = @RootOrder
AND C_ACCOUNT IS NOT NULL

-- recurrance definition

UNION ALL

select Level + 1,I_TSORDNUM, C_ACCOUNT, IIF(C_EVENT IN ('SPLIT ACCOUNT(S) FROM ORDER', 'SPLIT ORDER'), C_LINKFROM, I_AGGRFROM) AS LINKED_ORDER from #TRADE_ORDERS_AUDIT  branch
INNER JOIN OrderAllocationTrail root
ON root.OrderID = IIF(branch.C_EVENT IN ('SPLIT ACCOUNT(S) FROM ORDER', 'SPLIT ORDER'), branch.C_LINKFROM, branch.I_AGGRFROM)
	AND  IIF(branch.C_EVENT IN ('SPLIT ACCOUNT(S) FROM ORDER', 'SPLIT ORDER'), branch.C_LINKFROM,branch. I_AGGRFROM) <> branch.I_TSORDNUM
  -- patch to cope with corrupt data where an order seems to aggregate to itself
)

INSERT INTO #OrderAllocationTrail
SELECT * FROM OrderAllocationTrail

DELETE FROM #Orders WHERE I_TSORDNUM = @RootOrder

SELECT TOP 1 @RootOrder = I_TSORDNUM FROM #Orders ORDER BY 1 ASC

IF (SELECT COUNT(*) FROM #Orders) = 0

BREAK; 

END

-- Now build out the associations of Orders from root to end order
;WITH OrderAllocationTrail 
	(Level
	,RootOrderID
	,OrderID
	,AssociatedOrder
	)
AS
(
-- anchor definition
SELECT DISTINCT  Level, OrderID AS RootOrderID, OrderID, AGGRFrom AS AssociatedOrder FROM #OrderAllocationTrail WHERE Level = 0

-- recurrance definition
UNION ALL

SELECT  tree.Level, root.RootOrderID, tree.OrderID, tree.OrderID FROM #OrderAllocationTrail tree
INNER JOIN  OrderAllocationTrail root ON root.OrderID = tree.AGGRFrom AND root.Level + 1 = tree.Level 
)

SELECT	DISTINCT 
		 RootOrderID
		,OrderID
INTO #OrderTree
FROM OrderAllocationTrail

-- This gets messy
-- And then we have to go top down this is because a final order may well have multiple root order entry points and we have to know all of this before comparing initial vs final allocations
INSERT INTO #OrderTree
SELECT DISTINCT a.RootOrderID, b.RootOrderID FROM #OrderTree a 
INNER JOIN #OrderTree b ON 
a.ORDERID = b.OrderID
WHERE a.RootOrderID <> b.RootOrderID

-- pad out any missing orders from root orders that have been associate to other root orders via the tree
SELECT MAX(OrderID) AS EndOrderID, RootOrderID INTO #EndOrders FROM #OrderTree  
GROUP BY RootOrderID ORDER BY 1

SELECT DISTINCT ot.OrderID, eo.EndOrderID INTO #AllOrders FROM #OrderTree ot
OUTER APPLY (SELECT * FROM #EndOrders WHERE EndOrderID <> RootOrderID AND RootOrderID IN (ot.RootOrderID))  eo 
WHERE eo.EndOrderID IS NOT NULL

-- Insert Orders into the order tree for all Root Orders that are missing some of the information required to calculate volume differences
INSERT INTO #OrderTree
SELECT RootOrderID, OrderID FROM
(
	SELECT eo.RootOrderID, ao.OrderID, eo.EndOrderID, ot.OrderID AS MissingOrderID  FROM #AllOrders ao
	INNER JOIN #EndOrders eo 
	ON ao.EndOrderID = eo.EndOrderID 
	LEFT  JOIN #OrderTree ot ON ot.RootOrderID = eo.RootOrderID AND ot.OrderID = ao.OrderID 
) a WHERE MissingOrderID IS NULL


SELECT * INTO #ActivatedOrder
FROM
(
--SELECT DISTINCT C_IDENTIFIER, I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] FROM T_BBG_TCA_TRADE_ORDERS_AUDIT WHERE C_EVENT = 'ACTIVATED ORDER' AND ISNULL(C_BROKER,'~') NOT IN ('OPSTRAN', 'TEST', 'SPLIT', 'DIRECT', 'TESTBCEQ')
--	AND I_TSORDNUM NOT IN (SELECT Orders FROM #Orders)

--UNION ALL
SELECT DISTINCT C_IDENTIFIER, RootOrderID AS I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID)) * 100  AS [Percentage], CONVERT(VARCHAR(8),MIN(inf.D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] 
FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
INNER JOIN (SELECT DISTINCT RootOrderID, OrderID FROM #OrderTree) ord
ON i_TSORDNUM = OrderID
	--(SELECT ROW_NUMBER() OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT ORDER BY T_TIME ASC) AS ROWNUMBER, I_AUDITID, D_DATE, RootOrderID, OrderID
	--FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
	--INNER JOIN (SELECT RootOrderID, OrderID FROM #OrderTree) ord
	--ON i_TSORDNUM = OrderID
	--WHERE C_Event = 'ACTIVATED ORDER') dedupe	 
--ON inf.I_AUDITID = dedupe.I_AUDITID
--	AND inf.D_DATE = dedupe.D_DATE
WHERE C_Event = 'ACTIVATED ORDER'
--	AND ROWNUMBER = 1
) a


SELECT * INTO #AllocatedOrder
FROM 
(
	--SELECT DISTINCT C_IDENTIFIER, I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] FROM T_BBG_TCA_TRADE_ORDERS_AUDIT 
	--WHERE C_EVENT = 'ORDER ALLOCATED' AND ISNULL(C_BROKER,'~') NOT IN ('OPSTRAN', 'TEST', 'SPLIT', 'DIRECT', 'TESTBCEQ')
	--	AND I_TSORDNUM NOT IN (SELECT Orders FROM #Orders)

	--UNION ALL
	SELECT DISTINCT C_IDENTIFIER, RootOrderID AS I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY RootOrderID)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(inf.D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate]
	FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
	INNER JOIN (SELECT RootOrderID, OrderID FROM #OrderTree) ord
	ON i_TSORDNUM = OrderID
	where c_Event = 'ORDER ALLOCATED'
) b

-- Reload #Orders table with those that invalidate the percentage ratio rule
DELETE FROM #OrderTree

INSERT INTO #OrderTree(RootOrderID)
SELECT DISTINCT COALESCE(act.[I_TSORDNUM], allc.[I_TSORDNUM])
FROM #ActivatedOrder act
FULL OUTER JOIN #AllocatedOrder allc
ON act.I_TSORDNUM = allc.I_TSORDNUM
	AND act.C_ACCOUNT = allc.C_ACCOUNT
--WHERE ROUND(act.[Percentage],2) <> ROUND(allc.[Percentage],2)

TRUNCATE TABLE [Access.WebDev].[AllocationVolumeChanges]

INSERT INTO [Access.WebDev].[AllocationVolumeChanges]
(
	[OrderDate],
	[Year],
	[Month],
	Activated_Order, 
	Activated_Account, 
	Activated_Order_Amount, 
	Activated_Order_Pct, 
	Allocated_Order, 
	Allocated_Account, 
	Allocated_Order_Amount, 
	Allocated_Order_Pct,
	Stock
)
SELECT	DISTINCT
		COALESCE(act.[OrderDate], allc.[OrderDate]) AS [OrderDate],
		COALESCE(LEFT(act.[OrderDate],4), LEFT(allc.[OrderDate],4)) AS [Year],
		COALESCE(SUBSTRING(act.[OrderDate],5,2), SUBSTRING(allc.[OrderDate],5,2)) AS [Month],
		act.I_TSORDNUM AS Activated_Order, 
		act.C_ACCOUNT AS Activated_Account, 
		act.F_QUANTITY AS Activated_Order_Amount, 
		act.[Percentage]  AS Activated_Order_Pct, 
		allc.I_TSORDNUM AS Allocated_Order, 
		allc.C_ACCOUNT AS Allocated_Account, 
		allc.F_QUANTITY AS Allocated_Order_Amount, 
		allc.[Percentage]  AS Allocated_Order_Pct,
		COALESCE(sec.SECURITY_NAME, act.C_IDENTIFIER, act.C_IDENTIFIER) AS Stock	
FROM #ActivatedOrder act
FULL OUTER JOIN #AllocatedOrder allc
ON act.I_TSORDNUM = allc.I_TSORDNUM
	AND act.C_ACCOUNT = allc.C_ACCOUNT
INNER JOIN #OrderTree ord
ON COALESCE(act.[I_TSORDNUM],allc.[I_TSORDNUM]) = ord.RootOrderID
-- Try and identify incomplete order trees because of split orders
LEFT OUTER JOIN [dbo].[Vw_SecuritySourceIDs] ids
ON COALESCE(act.C_IDENTIFIER, allc.C_IDENTIFIER) = ids.SECURITY_ID
LEFT OUTER JOIN  dbo.T_MASTER_SEC   sec 
	ON ids.EDM_SEC_ID = sec.EDM_SEC_ID 
--ORDER BY COALESCE(act.I_TSORDNUM, allc.I_TSORDNUM)


