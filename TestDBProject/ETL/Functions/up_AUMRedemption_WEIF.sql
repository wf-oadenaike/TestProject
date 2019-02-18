CREATE FUNCTION [ETL].[up_AUMRedemption_WEIF] 
(	
)
RETURNS TABLE 
AS
-------------------------------------------------------------------------------------- 
-- Name: [ETL].[up_AUMRedemption_WEIF] 
-- 
-- Params:	
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 28/11/2017 DAP-1566 amended to only use confirmed data in T_MASTER_FUND_FLOW
-- R. Dixon: 22/01/2018 DAP-1690 amended for MKT_VAL to be equal to the Confirmed Gross Redemption - Confirmed Gross Subscription
-------------------------------------------------------------------------------------- 

RETURN 
(
	SELECT 
			(SELECT KPIBK 
			FROM	[KPI].[MeasuredKPIs] 
			WHERE	KPIDBBK ='AUMRedemption_WEIF') AS KPIID,
			FORMAT(red.Transaction_date,'yyyyMMdd') AS KPIDataDate,
			(ISNULL(red.MKT_VAL,0) - ISNULL(sub.MKT_VAL,0))/MKT_BASE AS Actual,
			0 as Target,
			--format(transactions.Transaction_date,'yyyy-MM-ddT00:00:00') as LastUpdatedDate
			FORMAT(GETDATE(),'yyyy-MM-ddTHH:mm:ss') AS LastUpdatedDate
	FROM
			(SELECT	CONVERT(DATE,Transaction_date) AS Transaction_date,SUM(MARKET_VALUE)AS MKT_VAL 
			FROM	[dbo].[T_MASTER_FUND_FLOW]
			WHERE	FUND_SHORT_NAME = 'WIMEIF' AND FUND_FLOW_TYPE = 'GROSS' AND FLOW_TYPE = 'REDEMPTION' AND SOURCE_TYPE = 'CONFIRMED'
			GROUP	BY CONVERT(DATE,Transaction_date)
			) red
	INNER	JOIN (SELECT	CONVERT(DATE,Transaction_date) AS Transaction_date,SUM(MARKET_VALUE)AS MKT_VAL 
			FROM	[dbo].[T_MASTER_FUND_FLOW]
			WHERE	FUND_SHORT_NAME = 'WIMEIF' AND FUND_FLOW_TYPE = 'GROSS' AND FLOW_TYPE = 'SUBSCRIPTION' AND SOURCE_TYPE = 'CONFIRMED'
			GROUP	BY CONVERT(DATE,Transaction_date)
			) sub
	ON		sub.Transaction_date = red.Transaction_date
	INNER	JOIN
			(SELECT CONVERT(DATE,Position_date) AS Position_date,
					SUM(TOTAL_ACCRUED_MARKET_VALUE_BASE) AS MKT_BASE 
			FROM	[dbo].[T_MASTER_FND_MARKET_VALUE]
			WHERE	FUND_SHORT_NAME = 'WIMEIF'
			GROUP	BY CONVERT(DATE,Position_date)
			) positions
	ON		positions.Position_date  = red.Transaction_date and MKT_BASE > 0
)
