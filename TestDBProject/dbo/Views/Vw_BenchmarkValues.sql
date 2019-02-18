

CREATE VIEW [dbo].[Vw_BenchmarkValues]
/******************************
** Desc: Generic Benchmark view
** Auth: R.Walker
** Date: 12/04/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-XXXX     12/04/2018  R.Walker	Initial version of view
** DAP-2325	04/10/2018  Add AsAtDate and AsOfDate
*******************************/
AS

    SELECT  
		 OrderID
		,Child_Order_Id
		,Account
		,Broker
		,Trade_Date_time AS Allocated_Time 
		,Trader_Date_time  	
		,DATEPART(yy,Trader_Date_time) AS TRADE_YEAR
		,DATEPART(mm, Trader_Date_time) AS TRADE_MONTH
		,Benchmark = 'IS/ACE'
		,Total_Value = ISNULL(TCA.TOTAL_VALUE, 0)
		,BenchmarkTotal = ISNULL(TCA.TOTAL_VALUE, 0) + ISNULL(B1NETREALDOLLAR, 0)
		,PLPos = CASE WHEN TCA.B1NETREALDOLLAR > 0 THEN TCA.B1NETREALDOLLAR ELSE 0 END
		,PLNeg = CASE WHEN TCA.B1NETREALDOLLAR < 0 THEN TCA.B1NETREALDOLLAR ELSE 0 END
		,Performance = CAST(IIF(ABS(ISNULL(TCA.B1NetPctCst,0)) > 0, TCA.B1NetPctCst, 0) AS DECIMAL(20,10))
		,TCA.Country
		,TCA.Symbol 
		,TCA.ReasonCode
		,CADIS_SYSTEM_UPDATED as AsAtDate 
		,Trader_Date_time as AsOfDate
    FROM 
         [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
	WHERE TCA.Country <> 'US'


UNION ALL

    SELECT
		 OrderID
		,Child_Order_Id
		,Account
		,Broker
		,Trade_Date_time AS Allocated_Time 
		,Trader_Date_time  	
		,DATEPART(yy,Trader_Date_time) AS TRADE_YEAR
		,DATEPART(mm, Trader_Date_time) AS TRADE_MONTH
		,Benchmark = 'IS/PTA'
		,Total_Value = ISNULL(TCA.TOTAL_VALUE, 0)
		,BenchmarkTotal = ISNULL(TCA.TOTAL_VALUE, 0) + ISNULL(B3NETREALDOLLAR, 0)
		,PLPos = CASE WHEN TCA.B3NETREALDOLLAR > 0 THEN TCA.B3NETREALDOLLAR ELSE 0 END
		,PLNeg = CASE WHEN TCA.B3NETREALDOLLAR < 0 THEN TCA.B3NETREALDOLLAR ELSE 0 END
		,Performance = CAST(IIF(ABS(ISNULL(TCA.B3NetPctCst,0)) > 0, TCA.B3NetPctCst, 0) AS DECIMAL(20,10))
		,TCA.Country
		,TCA.Symbol 
		,TCA.ReasonCode
			,CADIS_SYSTEM_UPDATED as AsAtDate 
		,Trader_Date_time as AsOfDate
    FROM 
         [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
	WHERE TCA.Country <> 'US'


UNION ALL

    SELECT  
		 OrderID
		,Child_Order_Id
		,Account
		,Broker
		,Trade_Date_time AS Allocated_Time 
		,Trader_Date_time  	
		,DATEPART(yy,Trader_Date_time) AS TRADE_YEAR
		,DATEPART(mm, Trader_Date_time) AS TRADE_MONTH
		,Benchmark = 'VWAP'
		,Total_Value = ISNULL(TCA.TOTAL_VALUE, 0)
		,BenchmarkTotal = ISNULL(TCA.TOTAL_VALUE, 0) + ISNULL(B2NETREALDOLLAR, 0)
		,PLPos = CASE WHEN TCA.B2NETREALDOLLAR > 0 THEN TCA.B2NETREALDOLLAR ELSE 0 END
		,PLNeg = CASE WHEN TCA.B2NETREALDOLLAR < 0 THEN TCA.B2NETREALDOLLAR ELSE 0 END
		,Performance = CAST(IIF(ABS(ISNULL(TCA.B2NetPctCst,0)) > 0, TCA.B2NetPctCst, 0) AS DECIMAL(20,10))
		,TCA.Country
		,TCA.Symbol 
		,TCA.ReasonCode
				,CADIS_SYSTEM_UPDATED as AsAtDate 
		,Trader_Date_time as AsOfDate
    FROM 
         [dbo].[T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED] TCA
	WHERE TCA.Country = 'US'


