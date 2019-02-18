CREATE PROCEDURE [Reporting].[usp_EDMDIPsGetDIPs]
	@RunDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[usp_EDMDIPsGetDIPs]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Obtains the deals in progress data for the email to the business.
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
	'WIMEIF' AS [FUND_SHORT_NAME]
	, SUM((CASE WHEN VALUE > 0 THEN VALUE ELSE 0 END)) AS Subscriptions
	, SUM((CASE WHEN VALUE < 0 THEN VALUE ELSE 0 END)) AS Redemptions
FROM
[dbo].[T_MASTER_DEALS_IN_PROGRESS] dips WHERE CONVERT(DATE, VALUATION_POINT) = @RunDate
)

SELECT 
	f.Short_Name AS Fund
	,f.Long_Name AS FundName
	,@RunDate AS [Date]
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY,Subscriptions), 1),2)  AS Subscriptions
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY,Redemptions), 1),2)  AS Redemptions
	, PARSENAME(CONVERT(varchar, CONVERT(MONEY, Subscriptions + Redemptions), 1),2)  AS NetValue
FROM 
	[dbo].[T_MASTER_FND] f
INNER JOIN 
	CTE_MV Data 
ON 
	LTRIM(RTRIM(REPLACE(REPLACE(f.[SHORT_NAME], CHAR(13), ''), CHAR(10), ''))) = data.[FUND_SHORT_NAME]
