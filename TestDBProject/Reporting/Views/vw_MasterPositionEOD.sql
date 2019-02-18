
CREATE VIEW [Reporting].[vw_MasterPositionEOD]

AS

---------------------------------------------------------------------------------------- 

----CREATE VIEW [Reporting].[vw_MasterPositionEOD]
----/******************************
----** Desc: Reporting view over Master Position
----**		 
----** Auth: R. Walker
----** Date: 14/02/2018
----**************************
----** Change History
----**************************
----** JIRA			Date		Author		Description 
----** ----			----------  -------		------------------------------------
----** DAP-1785     14/02/2018  R.Walker	Initial version of view
----** DAP-2314		03/09/2018  Olu			Modify Positions Weigihting to convert USD to GBP 
----** DAP-2340		20/09/2018  Olu			Modify Positions Weigihting to convert all currencies not GBP|GBp to GBP
----** DAP-2424		09/01/2018  Olu			Modify Positions Weigihting to use Sum  


----*******************************/





WITH CTE_CASH AS (
SELECT SUM (TradeDateCash) as TradeDateCash, FundShortName as FundShortName, tradeDate
			
			FROM 
(

SELECT  
DISTINCT 
			case when CurrencyCode NOT IN ('GBP') THEN TradeDateCash/FX_RATE 
			ELSE TradeDateCash
						 END
			  as TradeDateCash ,
			  cast(tradeDate as date) as tradeDate,  
			AccountName  as FundShortName , CurrencyCode
		    FROM dbo.T_NT_CASH_BALANCE cb
			inner join Reporting.vw_MasterPrice prc
			on cast(cb.TradeDate as date) = CAST(prc.PRICE_DATE AS date)
			AND CurrencyCode = PRICE_ISO_CCY
			AND PRICE_TYPE = 'EOD'
			
			
			) AS A
			GROUP BY FundShortName, tradeDate



)


select POSITION_DATE, FUND_SHORT_NAME, EDM_SEC_ID, SECURITY_NAME, POSITION_TYPE, LONG_SHORT_IND, SOURCE, QUANTITY, PRICE_TYPE, PRICE_ISO_CCY, [VALUE],  sum(valuecon) AS CASH,  WEIGHTING, CADIS_SYSTEM_INSERTED, CADIS_SYSTEM_UPDATED, CADIS_SYSTEM_CHANGEDBY, CADIS_SYSTEM_LASTMODIFIED, CADIS_SYSTEM_PRIORITY from 

(

SELECT DISTINCT
	   pos.[POSITION_DATE]
      ,pos.[FUND_SHORT_NAME]
	  ,pos.[EDM_SEC_ID]
	  ,prc.[SECURITY_NAME]
      ,pos.[POSITION_TYPE]
      ,pos.[LONG_SHORT_IND]
      ,pos.[SOURCE]
      ,pos.[QUANTITY]
	  ,prc.[PRICE_TYPE]
	  ,PRC.PRICE_ISO_CCY
	  ,pos.[QUANTITY] * prc.[MASTER_PRICE] AS [VALUE]	  
	 
		,ISNULL(CASE WHEN PRICE_ISO_CCY NOT IN ('GBP','GBp')
		THEN CAST(ISNULL(pos.[QUANTITY],0) * ISNULL((prc.[MASTER_PRICE]/prc.FX_RATE) * 100 ,0)   AS DECIMAL(18,6)) 
		ELSE  CAST(ISNULL(pos.[QUANTITY],0) * ISNULL(prc.[MASTER_PRICE],0)  AS DECIMAL(18,6)) 
	  		END,0) AS valuecon		
		,ISNULL(CASE WHEN PRICE_ISO_CCY NOT IN ('GBP','GBp')
		THEN CAST(ISNULL(pos.[QUANTITY],0) * ISNULL((prc.[MASTER_PRICE]/prc.FX_RATE * 100 ),0) / (TOTAL_MARKET_VALUE_BASE )    AS DECIMAL(18,6) ) 
		ELSE  CAST(ISNULL(pos.[QUANTITY],0) * ISNULL(prc.[MASTER_PRICE],0)/(TOTAL_MARKET_VALUE_BASE ) AS DECIMAL(18,6)) 
	  		END,0) AS [WEIGHTING]
		--,isnull(TradeDateCash,0)/TOTAL_MARKET_VALUE_BASE AS CASHWEIGHT
	  ,pos.[CADIS_SYSTEM_INSERTED]
      ,pos.[CADIS_SYSTEM_UPDATED]
      ,pos.[CADIS_SYSTEM_CHANGEDBY]
      ,pos.[CADIS_SYSTEM_PRIORITY]
      ,pos.[CADIS_SYSTEM_LASTMODIFIED]
FROM [dbo].[T_MASTER_POS] pos
INNER JOIN  Reporting.vw_MasterPrice prc
ON pos.EDM_SEC_ID = prc.EDM_SEC_ID
	AND pos.[POSITION_DATE] = prc.[PRICE_DATE]
LEFT OUTER JOIN [dbo].[T_MASTER_FND_MARKET_VALUE] val
ON pos.[POSITION_DATE] = val.[POSITION_DATE]
	AND pos.[POSITION_TYPE] = val.[POSITION_TYPE]
	AND pos.[FUND_SHORT_NAME] = val.[FUND_SHORT_NAME]
WHERE PRICE_TYPE = 'EOD'



UNION 


SELECT * FROM
(

SELECT   
     tradeDate
    ,FundShortName
    ,NULL  AS A
	,NULL  AS B
    ,NULL AS C
    ,NULL AS D
    ,NULL AS E
    ,NULL AS F
	,NULL AS G
	,NULL AS H
   , NULL AS [VALUE]	  
  ,TradeDateCash   
  ,NULL AS I
  ,NULL AS K
  ,NULL AS L 
  ,NULL AS M
  ,NULL AS N
  ,NULL AS O
  FROM CTE_CASH
) AS F
) as qd
WHERE POSITION_DATE = '2019/02/01'
AND FUND_SHORT_NAME = 'WIMPCT'
 group by  POSITION_DATE, FUND_SHORT_NAME,EDM_SEC_ID, SECURITY_NAME, POSITION_TYPE, LONG_SHORT_IND, SOURCE, QUANTITY, PRICE_TYPE, PRICE_ISO_CCY, [VALUE],  WEIGHTING, CADIS_SYSTEM_INSERTED, CADIS_SYSTEM_UPDATED, CADIS_SYSTEM_CHANGEDBY, CADIS_SYSTEM_LASTMODIFIED, CADIS_SYSTEM_PRIORITY 