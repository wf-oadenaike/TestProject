
CREATE FUNCTION [dbo].[ufn_XIRRviewREAL]()
 
RETURNS @OUTPUT TABLE
 (
 MONTHEND DATETIME,
 FUND VARCHAR(20),
 ISSUER VARCHAR(250),
 XIRR NUMERIC(38,12)
 )
 AS
BEGIN



WITH CTE_DATES(LastDayOfMonth)
 AS
 (

 -- Collect LastDayOfMonth and where it is not a weekday bring back the last day of Monday
SELECT  distinct  
  CASE WHEN  (DATEPART(weekday, lastdayofmonth) + @@DATEFIRST - 2) % 7 + 1 = 6 then DATEADD(DD, -1, LastDayOfMonth) 
       WHEN  (DATEPART(weekday, lastdayofmonth) + @@DATEFIRST - 2) % 7 + 1 = 7 then DATEADD(DD, -2, LastDayOfMonth) 
	   ELSE LastDayOfMonth 
END as LastDayOfMonth
FROM  Core.Calendar
WHERE YEAR(LastDayOfMonth) = YEAR(GETDATE())
)
 
 --Cross APPLY XIRR Function with CTE
 INSERT INTO @OUTPUT
 SELECT LastDayOfMonth, FUND, ISSUER, ROUND(XIRR,2) AS XIRR  FROM  CTE_DATES
 CROSS APPLY  dbo.ufn_ReturnXIRR_real(LastDayOfMonth)
 WHERE ISSUER IS NOT NULL
 
 RETURN
END 
 
