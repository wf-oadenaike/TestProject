
CREATE FUNCTION [Investment].[ufn_POS_FirstHeld]()
RETURNS @POS_FirstHeld TABLE
(
	[EDM_SEC_ID] INT NULL, 
	FUND_SHORT_NAME VARCHAR(50) NULL,
	Quantity_FirstDate DECIMAL(20,6) NULL, 
	Position_FirstDate DATE NULL
)
AS

-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[ufn_POS_FirstHeld]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		19/06/2017			JIRA: DAP-1150 used in View: [Investment].[DVD_Calculation]
--
-- 
-------------------------------------------------------------------------------------- 
 
BEGIN

	INSERT INTO @POS_FirstHeld
	--drop table #POS_FirstHeld
	SELECT P.[EDM_SEC_ID], P.FUND_SHORT_NAME, P.QUANTITY AS Quantity_FirstDate, P.POSITION_DATE AS Position_FirstDate
	--into #POS_FirstHeld
	FROM
		[dbo].[T_MASTER_POS] P
	INNER JOIN
	(
		SELECT [EDM_SEC_ID], FUND_SHORT_NAME, MIN(position_date) AS FirstPosition FROM [dbo].[T_MASTER_POS] WHERE FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF') GROUP BY [EDM_SEC_ID], FUND_SHORT_NAME
	) PHIST ON P.[EDM_SEC_ID] = PHIST.[EDM_SEC_ID] 
			AND P.FUND_SHORT_NAME = PHIST.FUND_SHORT_NAME 
			AND P.POSITION_DATE = PHIST.FirstPosition
	
	RETURN

END

