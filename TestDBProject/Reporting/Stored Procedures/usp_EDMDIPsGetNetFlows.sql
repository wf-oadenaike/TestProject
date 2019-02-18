CREATE PROCEDURE [Reporting].[usp_EDMDIPsGetNetFlows]
	@RunDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[usp_EDMDIPsGetNetFlows]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Obtains the Net Flows data for the email to the business.
-- 
-------------------------------------------------------------------------------------- 

Set NoCount on
	
DECLARE @DATA_DATE DATE

IF @RunDate IS NULL
BEGIN
	SET @RunDate = CONVERT(DATE, GETDATE())
END

-- DIPS is at T. AUM and flows are at T+1
SET @DATA_DATE = (CASE WHEN DATENAME(DW, @RunDate) = 'MONDAY' THEN DATEADD(dd, -3, @RunDate) ELSE DATEADD(dd, -1, @RunDate) END)

;WITH CTE_MV AS (
SELECT 
	LTRIM(RTRIM(REPLACE(REPLACE(ff.[FUND_SHORT_NAME], CHAR(13), ''), CHAR(10), ''))) AS [FUND_SHORT_NAME]
	, SUM(ff.NET_AMOUNT__BASE) AS MARKET_VALUE
	--, ff.Recognition
FROM
[dbo].[T_MASTER_NET_FUND_FLOW] ff WHERE THROUGH_DATE = @DATA_DATE --AND LTRIM(RTRIM(REPLACE(REPLACE(ff.[FUND_SHORT_NAME], CHAR(13), '') <> 'WIMEIF'
AND 
[NTRANCATG] IN ('Participant Contributions',
'Participant Withdrawals')
GROUP BY ff.[FUND_SHORT_NAME]
)

SELECT 
	f.Long_Name AS FundName
	,@DATA_DATE AS [Date]
	, ISNULL(Market_Value,0)  AS NetFlow
	, CASE WHEN Market_Value IS NOT NULL THEN CONVERT(varchar, CONVERT( MONEY,(Market_Value / 1000)), 1) ELSE '0.00' END AS DisplayValue	
	--,@DATA_DATE AS [Date]
FROM 
	[dbo].[T_MASTER_FND] f
LEFT JOIN 
	CTE_MV Data 
ON 
	LTRIM(RTRIM(REPLACE(REPLACE(f.[SHORT_NAME], CHAR(13), ''), CHAR(10), ''))) = data.[FUND_SHORT_NAME]
UNION ALL
	SELECT 'Total', @DATA_DATE AS [Date], SUM(Market_VALUE), CONVERT(varchar, CONVERT(MONEY,(SUM(Market_VALUE)/1000)), 1)
	FROM CTE_MV
