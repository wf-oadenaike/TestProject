

CREATE FUNCTION [Access.WebDev].[ufn_BERCAllocationVolumeChanges]
(
	@OrderID INT = NULL
)
RETURNS @Output TABLE (
						[OrderDate] VARCHAR(8),
						[Year] VARCHAR(4),
						[Month] VARCHAR(2),
						Activated_Order INT, 
						Activated_Account VARCHAR(20), 
						Activated_Order_Amount INT, 
						Activated_Order_Pct DECIMAL(10,6), 
						Allocated_Order INT, 
						Allocated_Account VARCHAR(20), 
						Allocated_Order_Amount INT, 
						Allocated_Order_Pct DECIMAL(10,6),
						Stock VARCHAR(100),
						slck_OrderID INT,
						slck_Message VARCHAR(MAX),
						slck_PostedBy VARCHAR(100),
						slck_Date DATETIME
					  )	
AS
-------------------------------------------------------------
------------------------- 
-- Name: [Access.WebDev].[ufn_BERCAllocationVolumeChanges]
-- 
-- Params:	@OrderID - Run for a specific order or everything. Default (NULL) - everything
-------------------------------------------------------------------------------------- 
-- History:
-- R. Walker: 13/07/2018 JIRA: DAP-2090 - Pre-execution change - Trades where the shares per account ratio between Activated vs Actual Allocations changed
-------------------------------------------------------------------------------------- 
BEGIN
DECLARE @Orders TABLE ( Root_Order INT, Orders INT )
DECLARE @ActivatedOrder TABLE (C_IDENTIFIER VARCHAR(30), I_TSORDNUM INT, C_ACCOUNT VARCHAR(20), F_QUANTITY INT, [Percentage] DECIMAL(10,6), [OrderDate] VARCHAR(8))
DECLARE @AllocatedOrder TABLE (C_IDENTIFIER VARCHAR(30), I_TSORDNUM INT, C_ACCOUNT VARCHAR(20), F_QUANTITY INT, [Percentage] DECIMAL(10,6), [OrderDate] VARCHAR(8))

---- Debug
--DECLARE @OrderID INT
--SET @OrderID = 19412

;WITH CTE_OrderTree AS 
	(
		SELECT DISTINCT dat.OrderID AS Root_Order, dat.OrderID AS ParentOrders, dat.Child_Order_ID, child.OrderID AS NextOrder  FROM "dbo"."T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED" dat
		INNER JOIN "dbo"."T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED" child 
		ON dat.Child_Order_ID = child.Child_Order_ID
		WHERE dat.Child_Order_ID <> dat.OrderID AND dat.OrderID = ISNULL(@OrderID, dat.OrderID)

		UNION ALL

		SELECT anchor.Root_Order, child.OrderID AS ParentOrders, child.Child_Order_ID, child.OrderID AS NextOrder FROM CTE_OrderTree anchor
		INNER JOIN (SELECT OrderID, Child_Order_ID FROM "dbo"."T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED") child
		ON anchor.NextOrder = child.OrderID
			AND child.OrderId <> child.Child_Order_ID
			AND anchor.ParentOrders <> child.OrderID
	),
CTE_Orders AS 
	(	SELECT MIN(Root_Order) AS Root_Order, ParentOrders AS Orders FROM CTE_OrderTree 
		GROUP BY ParentOrders
			UNION
		SELECT MIN(Root_Order) AS Root_Order, Child_Order_ID AS Orders FROM CTE_OrderTree
		GROUP BY Child_Order_ID 
	)

INSERT INTO @Orders
SELECT * FROM CTE_Orders

INSERT INTO @ActivatedOrder
SELECT *
FROM
(
SELECT DISTINCT C_IDENTIFIER, I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] FROM T_BBG_TCA_TRADE_ORDERS_AUDIT WHERE C_EVENT = 'ACTIVATED ORDER' AND ISNULL(C_BROKER,'~') NOT IN ('OPSTRAN', 'TEST', 'SPLIT', 'DIRECT', 'TESTBCEQ')
	AND I_TSORDNUM NOT IN (SELECT Orders FROM @Orders)
	AND I_TSORDNUM = ISNULL(@OrderID, I_TSORDNUM)

UNION ALL
SELECT DISTINCT C_IDENTIFIER, Root_Order AS I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY Root_Order)) * 100, CONVERT(VARCHAR(8),MIN(inf.D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] 
FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
INNER JOIN 
	(SELECT ROW_NUMBER() OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT ORDER BY T_TIME ASC) AS ROWNUMBER, I_AUDITID, D_DATE, Root_Order, Orders
	FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
	INNER JOIN (SELECT Root_Order, Orders FROM @Orders) ord
	ON i_TSORDNUM = Orders
	WHERE C_Event = 'ACTIVATED ORDER') dedupe	 
ON inf.I_AUDITID = dedupe.I_AUDITID
	AND inf.D_DATE = dedupe.D_DATE
WHERE C_Event = 'ACTIVATED ORDER'
	AND ROWNUMBER = 1
) a
WHERE 	CAST([OrderDate] AS VARCHAR(6)) >= CONVERT(VARCHAR(6), DATEADD(yy,-1,GETDATE()),112)
	AND CAST([OrderDate] AS VARCHAR(6)) < CONVERT(VARCHAR(6),GETDATE(),112)
OPTION (RECOMPILE)


INSERT INTO @AllocatedOrder
SELECT *
FROM 
(
	SELECT DISTINCT C_IDENTIFIER, I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY I_TSORDNUM)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate] FROM T_BBG_TCA_TRADE_ORDERS_AUDIT 
	WHERE C_EVENT = 'ORDER ALLOCATED' AND ISNULL(C_BROKER,'~') NOT IN ('OPSTRAN', 'TEST', 'SPLIT', 'DIRECT', 'TESTBCEQ')
		AND I_TSORDNUM NOT IN (SELECT Orders FROM @Orders)
		AND I_TSORDNUM = ISNULL(@OrderID, I_TSORDNUM)

	UNION ALL
	SELECT DISTINCT C_IDENTIFIER, Root_Order AS I_TSORDNUM, C_ACCOUNT, SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) AS F_QUANTITY, IIF(SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) = 0, 0, SUM(F_QUANTITY) OVER (PARTITION BY Root_Order, C_ACCOUNT) / SUM(F_QUANTITY) OVER (PARTITION BY Root_Order)) * 100 AS [Percentage], CONVERT(VARCHAR(8),MIN(inf.D_DATE) OVER (PARTITION BY I_TSORDNUM, C_ACCOUNT),112) AS [OrderDate]
	FROM T_BBG_TCA_TRADE_ORDERS_AUDIT inf
	INNER JOIN (SELECT Root_Order, Orders FROM @Orders)ord
	ON i_TSORDNUM = Orders
	where c_Event = 'ORDER ALLOCATED'
) b
WHERE 	CAST([OrderDate] AS VARCHAR(6)) >= CONVERT(VARCHAR(6), DATEADD(yy,-1,GETDATE()),112)
	AND CAST([OrderDate] AS VARCHAR(6)) < CONVERT(VARCHAR(6),GETDATE(),112)

-- Reload @Orders table with those that invalidate the percentage ratio rule
DELETE FROM @Orders

INSERT INTO @Orders(Root_Order)
SELECT DISTINCT COALESCE(act.[I_TSORDNUM], allc.[I_TSORDNUM])
FROM @ActivatedOrder act
FULL OUTER JOIN @AllocatedOrder allc
ON act.I_TSORDNUM = allc.I_TSORDNUM
	AND act.C_ACCOUNT = allc.C_ACCOUNT
WHERE ROUND(act.[Percentage],2) <> ROUND(allc.[Percentage],2)

INSERT INTO @Output
SELECT	COALESCE(act.[OrderDate], allc.[OrderDate]) AS [OrderDate],
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
		COALESCE(sec.SECURITY_NAME, act.C_IDENTIFIER, act.C_IDENTIFIER) AS Stock,
		slck.OrderID AS slck_OrderID,
		slck.Narrative AS slck_Message,
		slck.PostedBy AS slck_PostedBy,
		slck.EventDate AS slck_Date		
FROM @ActivatedOrder act
FULL OUTER JOIN @AllocatedOrder allc
ON act.I_TSORDNUM = allc.I_TSORDNUM
	AND act.C_ACCOUNT = allc.C_ACCOUNT
INNER JOIN @Orders ord
ON act.[I_TSORDNUM] = ord.Root_Order
	AND allc.[I_TSORDNUM] = ord.Root_Order
LEFT OUTER JOIN [dbo].[Vw_SecuritySourceIDs] ids
ON COALESCE(act.C_IDENTIFIER, allc.C_IDENTIFIER) = ids.SECURITY_ID
LEFT OUTER JOIN   dbo.T_MASTER_SEC   sec 
	ON ids.EDM_SEC_ID = sec.EDM_SEC_ID 
OUTER APPLY [dbo].[ufn_SlackCommentaryForOrderTree] (COALESCE(act.I_TSORDNUM, allc.I_TSORDNUM)) slck
ORDER BY COALESCE(act.I_TSORDNUM, allc.I_TSORDNUM)
OPTION (RECOMPILE) -- reset the cardinality of the variable tables. execution plan works on the assumption there is one record in that table.


RETURN

END