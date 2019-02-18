
CREATE VIEW [Access.WebDev].[AggregationPolicyFillsWithoutTimestamps]
/******************************
** Desc: Aggregation Policy - Utilitised by the Reporting team via EDM data generators 
		 / functions to display fills without timestamp violations
** Auth: R. Walker
** Date: 14/02/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1795     14/02/2018  R.Walker	Initial version of view
*******************************/
AS 


SELECT  SECURITY_NAME AS SecurityName, 
		ORDER_NUMBER AS OrderId, 
		EXEC_SEQ_NUMBER AS TradeExecutionSequenceNumber, 
		Ticker, 
		FILL_AMOUNT AS FillAmount, 
		EXEC_DATE AS TradeExecutionDate, 
		EXEC_TIME AS TradeExecutionTime,
		DATEPART(yy, FILE_DATE) AS [Year],
		DATEPART(mm, FILE_DATE) AS [Month], 
		EXEC_BRKR AS TradeExecutionBroker
FROM [dbo].[T_BBG_TCA_EMSX_TRADE_FILLS] 
WHERE (FILE_DATE < CONVERT(VARCHAR(6), GETDATE(), 112) + '01' -- restrict to rolling 12 months from end of last complete month 
	AND FILE_DATE >= DATEADD(yy, -1, (CONVERT(VARCHAR(6), GETDATE(), 112) + '01')))
	AND
		(EXEC_DATE IS NULL OR EXEC_TIME IS NULL)



