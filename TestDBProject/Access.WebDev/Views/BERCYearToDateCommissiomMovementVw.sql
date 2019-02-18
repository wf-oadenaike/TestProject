
CREATE VIEW [Access.WebDev].[BERCYearToDateCommissiomMovementVw] 
AS 
  /****************************** 
  ** Desc: Yearly Rolling Commission by Month 
  ** Auth: R.Walker 
  ** Date: 18/06/2018 
  ************************** 
  ** Change History 
  ************************** 
  ** JIRA      Date    Author    Description  
  ** ----      ----------  -------    ------------------------------------   
  ** DAP-2096    18/06/2018  R.Walker  Initial version of view  
  ** DAP-2325 	04/10/2018   Olu  Add AsAtDate and AsOfDate
  *******************************/ 
  WITH cte_agg 
       AS (SELECT [year], 
                  [month], 
                  Sum(totalcommission) 
                     AS TotalCommissionByCalendarMonth, 
                  Sum(totalcommission) / Sum(totalnotionalvalue) 
                     AS BlendedRatebps, 
                  Sum(totalnotionalvalue) 
                     AS TotalNotionalValueByMonth, 
                  Row_number() 
                    OVER ( 
                      ORDER BY Cast(Cast([year] AS CHAR(4)) + Cast([month] AS 
                    CHAR 
                    (2)) 
                    AS 
                    INT)) AS 
                  RowOrder, 
                  Max(AsAtDate) 
                     AS LastUpdatedDate 
           --, SUM(TotalTrades) AS TotalTradesByMonth -- does this work for US commissions where commission comes from vol of shares rather then total price
           FROM   [Access.WebDev].[bercmonthlycommissionbybrokervw] 
           GROUP  BY [year], 
                     [month]), 
       cte_recursive 
       AS (SELECT TOP 1 [year], 
                        [month], 
                        totalcommissionbycalendarmonth, 
                        blendedratebps * 10000         AS AverageCompRateYTD, 
                        totalcommissionbycalendarmonth AS AverageCompValueYTD, 
                        totalcommissionbycalendarmonth AS TotalCompValueYTD, 
                        totalnotionalvaluebymonth, 
                        totalnotionalvaluebymonth      AS 
                            AccumulativeTotalNotionalValueByMonth, 
                        roworder, 
                        lastupdateddate as AsAtDate,
						lastupdateddate as AsOfDate
						--, TotalTradesByMonth  
           FROM   cte_agg 
           ORDER  BY roworder ASC 
           UNION ALL 
           SELECT a.[year], 
                  a.[month], 
                  a.totalcommissionbycalendarmonth, 
                  Iif(a.[month] = 1, a.totalcommissionbycalendarmonth / 
                                     a.totalnotionalvaluebymonth, 
                  ( vw.totalcompvalueytd 
                  + a.totalcommissionbycalendarmonth ) / ( 
                  accumulativetotalnotionalvaluebymonth 
                  + a.totalnotionalvaluebymonth )) * 
                  10000                                           AS 
                  AverageCompRateYTD 
                  , 
                  Iif(a.[month] = 1, a.totalcommissionbycalendarmonth, 
                  ( vw.totalcompvalueytd 
                    + 
                  a.totalcommissionbycalendarmonth ) / a.[month]) AS 
                  AverageCompValueYTD, 
                  Iif(a.[month] = 1, a.totalcommissionbycalendarmonth, 
                  vw.totalcompvalueytd 
                  + 
                  a.totalcommissionbycalendarmonth)               AS 
                  TotalCompValueYTD, 
                  a.totalnotionalvaluebymonth, 
                  Iif(a.[month] = 1, a.totalnotionalvaluebymonth, 
                  accumulativetotalnotionalvaluebymonth 
                  + a.totalnotionalvaluebymonth)                  AS 
                  AccumulativeTotalNotionalValueByMonth, 
                  a.roworder, 
                  a.lastupdateddate as AsAtDate,
				  a.lastupdateddate as AsOfDate
				  --, a.TotalTradesByMonth 
           FROM   cte_recursive vw 
                  INNER JOIN cte_agg a 
                          ON vw.roworder + 1 = a.roworder) 
  SELECT * 
  FROM   cte_recursive 

