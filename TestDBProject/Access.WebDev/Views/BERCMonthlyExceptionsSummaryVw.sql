 

CREATE VIEW [Access.WebDev].[BERCMonthlyExceptionsSummaryVw]
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
** DAP-1405     14/11/2017  D.Fanning   Expand benchmarks to 3 
** DAP-1764		06/02/2017	W.Stubbs	Complete rewrite - point to deagg data, plus reason codes
										and exception thresholds in tables
** DAP-1570		14/05/2018	R.Walker	Use the Order level significant trades to supply the summary data
										thus keeping the figures in line
*******************************/
SELECT	 DISTINCT
		 X.[Year]
		,X.[Month]
		,X.Benchmark
		,SUM(IIF(X.PerformanceBPS > 0, 1, 0)) OVER (PARTITION BY X.[Year], X.[Month], Benchmark) AS PositivePerformanceCount
		,SUM(IIF(X.PerformanceBPS < 0, 1, 0)) OVER (PARTITION BY X.[Year], X.[Month], Benchmark) AS NegativePerformanceCount
FROM [Access.WebDev].[BERCMostSignificantTradesOrderDetail_Vw] X
WHERE  CAST(CAST(X.[Year] AS VARCHAR(4)) + CAST(FORMAT(X.[Month], '00') AS VARCHAR(2)) + '01' AS DATE) >= DATEADD(mm, -12, CONVERT(VARCHAR(6), GETDATE(), 112) + '01') 
	AND CAST(CAST(X.[Year] AS VARCHAR(4)) + CAST(FORMAT(X.[Month], '00') AS VARCHAR(2)) + '01' AS DATE) < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' 


