CREATE FUNCTION [Access.WebDev].[ufn_GetOverdraftDaysCount]
(
	@PositionDate DATE = NULL
)
RETURNS @Output TABLE (
    [FUND_SHORT_NAME] VARCHAR(256) NULL,
	[OverdraftDays] INTEGER NULL,
	[POSITION_DATE] DATE
)

AS
-------------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_GetOverdraftDaysCount]
-- 
-- Params:	@PositionDate DATE - Trade date for which the function is to be run for.
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 28/11/2017 OPP-935 rewritten to simplify SQL. Also amended to reflect overdrawn
--						position out of 360 days
-- R. Dixon: 15/01/2018 DAP-1663 Exclude current date from logic that checks if we don't have a value (e.g. weekend)
--						then we look for the most recent value prior to that date.
-------------------------------------------------------------------------------------- 

BEGIN
	
IF @PositionDate IS NULL
	SET @PositionDate = CONVERT(DATE,GetDate());

	INSERT	INTO @Output
			([FUND_SHORT_NAME],
			[OverdraftDays],
			[POSITION_DATE])
	SELECT	PD.SHORT_NAME, ISNULL(SUM(BASE_VALUE),0) AS OverdraftDays, MAX(DT.POSITION_DATE) AS POSITION_DATE
	FROM	(
			SELECT	SHORT_NAME, MAX(BV.BASE_VALUE) AS BASE_VALUE, BV.CalendarDate
			FROM
					(                          
					SELECT F.SHORT_NAME, 
							BASE_VALUE  = CASE 
								WHEN (COALESCE(BASE_VALUE, (SELECT	TOP 1 BASE_VALUE 
															FROM	[T_MASTER_POS_ACCOUNT_BALANCE] P2 
															WHERE	P2.POSITION_DATE < C.CALENDARDATE
															AND		P2.FUND_SHORT_NAME = F.SHORT_NAME 
															ORDER  BY P2.POSITION_DATE DESC, BASE_VALUE ASC))) < 0 THEN 1 
								ELSE 0 END, 
								C.CALENDARDATE
					FROM   T_MASTER_FND F
					CROSS  APPLY CORE.CALENDAR C
					LEFT   OUTER JOIN [DBO].[T_MASTER_POS_ACCOUNT_BALANCE] P
					ON		F.SHORT_NAME = P.FUND_SHORT_NAME
					AND		CONVERT(DATE, P.POSITION_DATE) = C.CALENDARDATE
					WHERE	C.CALENDARDATE BETWEEN DATEADD(D,-360,@PositionDate) AND DATEADD(D,-1,@PositionDate)
					) BV
			GROUP	BY BV.SHORT_NAME, CalendarDate
			) PD
	LEFT	OUTER JOIN
            (
            SELECT	FUND_SHORT_NAME, MAX(POSITION_DATE) AS POSITION_DATE
            FROM	[T_MASTER_POS_ACCOUNT_BALANCE] 
            GROUP	BY FUND_SHORT_NAME
            ) DT
	ON		DT.FUND_SHORT_NAME = PD.SHORT_NAME
	GROUP  BY PD.SHORT_NAME

  RETURN
   
END


