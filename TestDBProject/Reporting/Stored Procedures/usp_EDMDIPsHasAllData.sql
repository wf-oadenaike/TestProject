CREATE PROCEDURE [Reporting].[usp_EDMDIPsHasAllData]
	@RunDate date = NULL
AS
-------------------------------------------------------------------------------------- 
-- Name:			[Reporting].[Reporting.usp_EDMDIPsHasAllData]
-- 
-- Note:			
-- 
-- Author:			K Wu
-- Date:			26/01/2016
-------------------------------------------------------------------------------------- 
-- History:			Initial Write 
-- Description:		Checks if data is available for AUM, net flows and DIPs. Returns 1 if it is ready. 0 if it is not.
-- 
-------------------------------------------------------------------------------------- 

Set NoCount on
	
DECLARE @DATA_DATE DATE

DECLARE @HaveAUM BIT
DECLARE @HaveNetFlows BIT
DECLARE @HaveDIPs BIT
DECLARE @HaveOmnis BIT

SET @HaveAUM = 0
SET @HaveNetFlows = 0
SET @HaveDIPs = 0
SET @HaveOmnis = 0

IF @RunDate IS NULL
BEGIN
	SET @RunDate = CONVERT(DATE, GETDATE())
END

-- DIPS is at T. AUM and flows are at T+1
SET @DATA_DATE = (CASE WHEN DATENAME(DW, @RunDate) = 'MONDAY' THEN DATEADD(dd, -3, @RunDate) ELSE DATEADD(dd, -1, @RunDate) END)

SELECT TOP 1 @HaveNetFlows =1 FROM [dbo].[T_MASTER_FUND_FLOW]
WHERE Transaction_Date = @DATA_DATE AND [FUND_FLOW_TYPE] = 'NET'

SELECT TOP 1 @HaveDIPs =1 FROM [dbo].[T_MASTER_DEALS_IN_PROGRESS]
WHERE CONVERT(DATE, VALUATION_POINT) = @RunDate

SELECT TOP 1 @HaveAUM = 1 FROM [dbo].[T_MASTER_FND_MARKET_VALUE]
WHERE Position_DATE = @DATA_DATE

SELECT TOP 1 @HaveOmnis =1 FROM [dbo].[T_MASTER_FND_SHARE_CLASS_FLOW]
WHERE CONVERT(DATE, VALUATION_POINT_DATE) = @RunDate

IF @HaveDIPs = 1 AND @HaveNetFlows = 1 AND @HaveAUM = 1 AND @HaveOmnis = 1
SELECT 1 AS AllDataAvailable
ELSE
SELECT 0 AS AllDataAvailable
