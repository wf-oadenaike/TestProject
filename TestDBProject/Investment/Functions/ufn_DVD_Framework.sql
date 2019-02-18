

CREATE FUNCTION [Investment].[ufn_DVD_Framework]()
RETURNS @DVD_Framework TABLE
(
	[EDM_SEC_ID] INT NULL, 
	ExDate DATE NULL, 
	DvdValue_ExDate DECIMAL(20,6) NULL, 
	FUND_SHORT_NAME VARCHAR(50) NULL,
	Quantity_LastDate DECIMAL(20,6) NULL, 
	Position_LastDate DATE NULL
)

AS 

-------------------------------------------------------------------------------------- 
-- Name:			[Investment].[ufn_DVD_Framework]
-- 
-- Params:			
-- 
-------------------------------------------------------------------------------------- 
-- History:			

-- WHO				WHEN				WHY
-- D.Bacchus:		19/06/2017			JIRA: DAP-1150 used in View: [Investment].[DVD_Calculation]
-- D.Fanning		13/09/2017			JIRA: DAP-1331 Prioritise Historical dividends over projected
-- 
-------------------------------------------------------------------------------------- 

BEGIN
	DECLARE @currentDate AS DATETIME
	
	--// Dividends analisys scope is for securities owned within the current year. ie Every security Woodford has owned this year.
	SET @currentDate = (SELECT MAX(POSITION_DATE) FROM [dbo].[T_MASTER_POS])

	INSERT INTO @DVD_Framework
	SELECT H.[EDM_SEC_ID], H.[EX_DATE], H.[DVD_VALUE] AS DVD_VALUE_ExDate, X.FUND_SHORT_NAME, X.QUANTITY AS Quantity_LastDate, X.POSITION_DATE AS Position_LastDate
	--into @DVD_Framework
	FROM 
		(
			--// JIRA: DAP-1331 Prioritise Historical dividends over projected, exclude 
			SELECT H.[EDM_SEC_ID], H.[EX_DATE], SUM(H.[DVD_VALUE]) AS [DVD_VALUE] FROM [dbo].[T_BPS_DVD_HIST] H
			WHERE H.DVD_TYPE IN ('Special Cash', 'Interim', '1st Interim', '2nd Interim', '3rd Interim', '4th Interim', 'Income', 'Final', 'Regular Cash', 'Interest on Capital', 'Return of Capital')
			AND	DATEPART(YY, H.EX_DATE) >= (DATEPART(YY, @currentDate))
			AND DATEPART(YY, H.EX_DATE) <= (DATEPART(YY, @currentDate) + 1)
			GROUP BY H.[EDM_SEC_ID],H.[EX_DATE]
			UNION
			SELECT P.[EDM_SEC_ID], P.[EX_DATE], SUM(P.[DVD_VALUE]) AS [DVD_VALUE] FROM [dbo].[T_BPS_DVD_PROJECT] P
			WHERE DATEPART(YY, P.EX_DATE) >= (DATEPART(YY, @currentDate))
			AND DATEPART(YY, P.EX_DATE) <= (DATEPART(YY, @currentDate) + 1)
			AND NOT EXISTS (SELECT TOP 1 [EDM_SEC_ID], [EX_DATE] FROM [dbo].[T_BPS_DVD_HIST] X
							WHERE DATEPART(YY, X.EX_DATE) >= (DATEPART(YY, @currentDate))
							AND DATEPART(YY, X.EX_DATE) <= (DATEPART(YY, @currentDate) + 1)
							AND X.[EDM_SEC_ID] = P.[EDM_SEC_ID]
							AND X.[EX_DATE] = P.[EX_DATE])
			GROUP BY P.[EDM_SEC_ID],P.[EX_DATE]		
		) H 
	CROSS JOIN
		(
		SELECT P.[EDM_SEC_ID], P.FUND_SHORT_NAME, P.QUANTITY, P.POSITION_DATE
		FROM
			[dbo].[T_MASTER_POS] P
		INNER JOIN
		(
			SELECT [EDM_SEC_ID], FUND_SHORT_NAME, MAX(position_date) AS LastPosition FROM [dbo].[T_MASTER_POS] WHERE FUND_SHORT_NAME IN ('WIMEIF', 'WIMIFF') AND QUANTITY > 0 GROUP BY [EDM_SEC_ID], FUND_SHORT_NAME
		) PHIST ON P.[EDM_SEC_ID] = PHIST.[EDM_SEC_ID] 
				AND P.FUND_SHORT_NAME = PHIST.FUND_SHORT_NAME 
				AND P.POSITION_DATE = PHIST.LastPosition
		) X 
	WHERE H.EDM_SEC_ID = X.EDM_SEC_ID
	AND	DATEPART(YY, H.EX_DATE) >= (DATEPART(YY, @currentDate))
	AND DATEPART(YY, H.EX_DATE) <= (DATEPART(YY, @currentDate) + 1)
	
	RETURN

END

