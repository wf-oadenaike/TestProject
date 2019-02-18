
CREATE VIEW [Access.WebDev].[BERCMonthlyExceptionsVw]
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
** DAP-1405     30/10/2017  D.Fanning   Initial version of view
** DAP-1764		06/02/2018	W.Stubbs	Major rewrite - point at deagg data, and reason codes
										and exceptions thresholds in tables
** DAP-1798		15/02/2018	R.Walker	Expose Reason Codes & Description
** DAP-1570		04/05/2018	R.Walker	Use this previously deprecated view to combine the significant
										trades Order level and broker level detail together
*******************************/

     SELECT  
		ord.OrderId AS ord_OrderId,
		ord.Security_Name AS ord_Security_Name,
		ord.[Broker] AS ord_Broker,
		ord.Country AS ord_Country,
		ord.TotalValue AS ord_TotalValue,
		bps.ord_PerformanceBPS,
		ord.TCAException AS ord_TCAException,
		ord.Benchmark AS ord_Benchmark,
		ord.ReasonCode AS ord_ReasonCode,
		ord.ReasonCodeDescriptive AS ord_ReasonCodeDescriptive,
		ord.BenchmarkTotal AS ord_BenchmarkTotal,
		ord.PL AS ord_PL,
		bkr.OrderId AS bkr_OrderId,
		bkr.Security_Name AS bkr_Security_Name,
		bkr.[Broker] AS bkr_Broker,
--		bkr.Country AS bkr_Country,
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
	FROM [Access.WebDev].BERCMostSignificantTradesOrderDetail_Vw ord
	INNER JOIN [Access.WebDev].BERCMostSignificantTradesBrokerDetail_Vw bkr
	ON ord.OrderId = bkr.OrderId
		AND ord.Benchmark = bkr.Benchmark
	INNER JOIN (SELECT OrderID, SUM(PerformanceBPS) AS ord_PerformanceBPS FROM [Access.WebDev].BERCMostSignificantTradesBrokerDetail_Vw GROUP BY OrderID) bps 
	ON ord.OrderId = bps.OrderID
	OUTER APPLY [dbo].[ufn_SlackCommentaryForOrderTree](ord.OrderId) slck
	WHERE CAST(ord.[Year] AS VARCHAR(4)) + FORMAT(ord.[Month],'00') = CONVERT(VARCHAR(6), DATEADD(mm,-1,GETDATE()),112)

		
		

		

