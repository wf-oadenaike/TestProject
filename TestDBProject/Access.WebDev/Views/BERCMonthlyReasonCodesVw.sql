
CREATE VIEW [Access.WebDev].[BERCMonthlyReasonCodesVw]
AS
/******************************
** Desc:
** Auth: D.Fanning
** Date: 30/10/2017
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-2092		12/06/2018	R.Walker	Initial Version Rewrite / refactor view migrate to new name
*******************************/

    SELECT 
		ord.[Year] AS ord_Year,
		ord.[Month] AS ord_Month,
		ord.OrderId AS ord_OrderId,
		ord.OrderDate AS ord_OrderDate,
		ord.Security_Name AS ord_Security_Name,
		ord.[Broker] AS ord_Broker,
		ord.Country AS ord_Country,
		ord.TotalValue AS ord_TotalValue,
		ord.TCAException AS ord_TCAException,
		ord.Benchmark AS ord_Benchmark,
		ord.ReasonCode AS ord_ReasonCode,
		ord.ReasonCodeDescriptive AS ord_ReasonCodeDescriptive,
		ord.TotalValue AS ord_BenchmarkTotal,
		bkr.OrderId AS bkr_OrderId,
		bkr.Security_Name AS bkr_Security_Name,
		bkr.[Broker] AS bkr_Broker,
		bkr.TotalValue AS bkr_TotalValue,
		bkr.PerformanceBPS AS bkr_PerformanceBPS,
--		bkr.Benchmark AS bkr_Benchmark,
		bkr.ReasonCode AS bkr_ReasonCode,
		bkr.ReasonCodeDescriptive AS bkr_ReasonCodeDescriptive,
		bkr.BenchmarkTotal AS bkr_BenchmarkTotal,
		bkr.PL AS bkr_PL,
		slck.OrderID AS slck_OrderID,
		slck.Narrative AS slck_Message,
		slck.PostedBy AS slck_PostedBy,
		slck.EventDate AS slck_Date			
	FROM [Access.WebDev].BERCMonthlyReasonCodesOrderDetail_Vw ord
	INNER JOIN [Access.WebDev].BERCMostSignificantTradesBrokerDetail_Vw bkr
	ON ord.OrderId = bkr.OrderId
		AND ord.Benchmark = bkr.Benchmark
	INNER JOIN (SELECT OrderID, SUM(PerformanceBPS) AS ord_PerformanceBPS FROM [Access.WebDev].BERCMostSignificantTradesBrokerDetail_Vw GROUP BY OrderID) bps 
	ON ord.OrderId = bps.OrderID
	OUTER APPLY [dbo].[ufn_SlackCommentaryForOrderTree](ord.OrderId) slck
	WHERE (
		-- either year is one less than current and month is equal or greater
		(ord.[Year] = YEAR(GETDATE()) -1 AND ord.[Month] >= MONTH(GETDATE()))
		or
		-- or year is equal to current and month is less
		(ord.[Year] = YEAR(GETDATE()) AND ord.[Month] < MONTH(GETDATE()))
		)


