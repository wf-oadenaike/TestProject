

CREATE VIEW [dbo].[VW_Compliance_Rec_TCA_Output_vs_ITG_Response]
/******************************
** Desc: Compliance - Reconcile the data our process sends ITG vs ITG response
** Auth: R. Walker
** Date: 28/03/2018
**************************
** Change History
**************************
** JIRA			Date		Author		Description 
** ----			----------  -------		------------------------------------
** DAP-1822     28/03/2018  R.Walker	Initial version of view
******************************/
AS 
WITH CTE_REC AS (
					SELECT	ISNULL(CONVERT(DATE,outbnd.DecisionDateTime), inbnd.origDecisionDate) AS Search_Decision_Date, 
							CAST(ISNULL(outbnd.AllocationDateTime, inbnd.Trade_Date_Time) AS DATETIME) AS Trade_Date_Time,
							ISNULL(outbnd.ParentOrderID,inbnd.OrderId) AS ParentOrderID,
							ISNULL(outbnd.OrderId,inbnd.Child_Order_Id) AS ChildOrderID,
							ISNULL(outbnd.Account,inbnd.Account) AS Account,
							ISNULL(outbnd.BrokerID,inbnd.Broker) AS Broker,
							outbnd.DecisionDateTime AS To_ITG_Decision_Date,
							inbnd.origDecisionDate AS From_ITG_Decision_Date,
							IIF(ISNULL(CONVERT(VARCHAR(10),inbnd.origDecisionDate,120),'1901-01-01') = ISNULL(CONVERT(VARCHAR(10),outbnd.DecisionDateTime),'1901-01-01'), 1, 0) AS [ITG_Decision_Date_Matched?],
							outbnd.ParentOrderID AS To_ITG_Parent_Order_ID, 
							inbnd.OrderId AS From_ITG_Parent_Order_ID, 
							IIF(ISNULL(outbnd.ParentOrderID,1) = ISNULL(inbnd.OrderId,1), 1, 0) AS [ITG_Parent_Order_ID_Matched?],
							outbnd.OrderId AS To_ITG_Child_Order_ID,
							inbnd.Child_Order_Id  AS From_ITG_Child_Order_ID, 
							IIF(ISNULL(outbnd.OrderId,1) = ISNULL(inbnd.Child_Order_Id,1), 1, 0) AS [ITG_Child_Order_ID_Matched?],
							outbnd.Symbol AS To_ITG_Symbol,
							inbnd.Symbol AS From_ITG_Symbol,	
							IIF(ISNULL(outbnd.Symbol,'~') = ISNULL(inbnd.Symbol,'~'), 1, 0) AS [ITG_Symbol_Matched?],
							IIF(inbnd.Ticker IS NOT NULL, LEFT(REPLACE(outbnd.C_SECURITY,'/','.'),LEN(ISNULL(inbnd.Ticker ,'~'))), outbnd.C_SECURITY) AS To_ITG_Ticker,
							inbnd.Ticker AS From_ITG_Ticker,		 
							IIF(ISNULL(IIF(inbnd.Ticker IS NOT NULL, LEFT(REPLACE(outbnd.C_SECURITY,'/','.'),LEN(ISNULL(inbnd.Ticker ,'~'))), outbnd.C_SECURITY),'~') = ISNULL(inbnd.Ticker,'~'), 1, 0) AS [ITG_Ticker_Matched?],
							outbnd.Side AS To_ITG_Side,
							inbnd.Side AS From_ITG_Side,		 
							IIF(ISNULL(outbnd.Side,'~') = ISNULL(inbnd.Side,'~'), 1, 0) AS [ITG_Side_Matched?],
							outbnd.BrokerID AS To_ITG_Broker, 
							inbnd.Broker AS From_ITG_Broker,
							IIF(ISNULL(outbnd.BrokerID,'~') = ISNULL(inbnd.Broker,'~'), 1, 0) AS [ITG_Broker_Matched?],
							outbnd.TotalOrderSize AS To_ITG_Total_Order_Size,
							inbnd.OrderShares AS From_ITG_Total_Order_Size, 
							IIF(ISNULL(CAST(outbnd.TotalOrderSize AS decimal(24,10)),0) = ISNULL(inbnd.OrderShares,0), 1, 0) AS [ITG_Total_Order_Size_Matched?],
							outbnd.Shares AS To_ITG_Shares, 
							inbnd.Trade_Shares AS From_ITG_Shares,
							IIF(ISNULL(CAST(outbnd.Shares AS decimal(20,0)),0) = ISNULL(inbnd.Trade_Shares,0), 1, 0) AS [ITG_Shares_Matched?],
							IIF(outbnd.Reasoncode IN ('EX','CU'), ISNULL(TRY_CAST(outbnd.Price AS money), 0) - ISNULL(TRY_CAST(outbnd.Dividend AS money), 0) - ISNULL(TRY_CAST(outbnd.SpecialDividend AS money), 0), ISNULL(TRY_CAST(outbnd.Price AS money), 0)) AS To_ITG_Price,			-- Handling asjustments for Dividend and Special Ex
							inbnd.Orig_Price AS From_ITG_Price,
							IIF(IIF(outbnd.Reasoncode IN ('EX','CU'), ISNULL(TRY_CAST(outbnd.Price AS money),0) - ISNULL(TRY_CAST(outbnd.Dividend AS money),0) - ISNULL(TRY_CAST(outbnd.SpecialDividend AS money), 0), ISNULL(TRY_CAST(outbnd.Price AS money),0)) = ISNULL(TRY_CAST(inbnd.Orig_Price AS money),0), 1, 0) AS [ITG_Price_Matched?],
							outbnd.Account AS To_ITG_Account,
							inbnd.Account AS From_ITG_Account,		 
							IIF(ISNULL(outbnd.Account,'~') = ISNULL(inbnd.Account,'~'), 1, 0) AS [ITG_Account_Matched?],
							outbnd.BrokerCommission AS To_ITG_Broker_Commission, 
							inbnd.Total_Commission_In_Base_Currency AS From_ITG_Broker_Commission, 
							IIF(ABS(ISNULL(TRY_CAST(outbnd.BrokerCommission AS money),-1) - ISNULL(TRY_CAST(inbnd.Total_Commission_In_Base_Currency AS money),-1)) < 1, 1, 0) AS [ITG_Broker_Commission_Matched?], -- add a tolerance to mitigate rounding issues
							outbnd.Dividend AS To_ITG_Dividend,
							inbnd.Dividend AS From_ITG_Dividend,		 
							IIF(ISNULL(TRY_CAST(outbnd.Dividend AS money),'-1') = ISNULL(TRY_CAST(inbnd.Dividend AS money),'-1'), 1, 0) AS [ITG_Dividend_Matched?],
							outbnd.SpecialDividend AS To_ITG_Special_Dividend, 
							inbnd.Special_Dividend AS From_ITG_Special_Dividend,		 
							IIF(ISNULL(TRY_CAST(outbnd.SpecialDividend AS money),'-1') = ISNULL(TRY_CAST(inbnd.Special_Dividend AS money),'-1'), 1, 0) AS [ITG_Special_Dividend_Matched?],
							outbnd.Reasoncode AS To_ITG_Reason_Code, 
							inbnd.Reasoncode AS From_ITG_Reason_Code,
							IIF(ISNULL(outbnd.Reasoncode,'~') = ISNULL(inbnd.Reasoncode,'~'), 1, 0) AS [ITG_Reason_Code_Matched?], 
							(SELECT COUNT(1) FROM TCA.BETA_TCAOutputresults WHERE CAST(DecisionDateTime AS DATETIME) >= CONVERT(VARCHAR(8),DATEADD(dd,-10,GETDATE()),112) AND LEFT(C_SECURITY,1) <> '.') AS TotalRecordsSentLast10Days, -- first character "." means unquoted security which ITG won't provide info on
							(SELECT COUNT(1) FROM dbo.T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED_STAGING stg LEFT OUTER JOIN (SELECT DISTINCT ParentOrderID, OrderId FROM "TCA"."BETA_TCAOutputresults") cur
								ON stg.OrderId = cur.ParentOrderID AND stg.Child_Order_Id = cur.OrderId
							WHERE Decision_Date_Time >= CONVERT(VARCHAR(8),DATEADD(dd,-10,GETDATE()),112)) AS TotalRecordsReceivedLast10Days, -- ITG appear to send us a rolling 11 days data
							CAST(IIF(outbnd.ParentOrderID IS NOT NULL, 'True', 'False') AS BIT) AS IsLatestFile
					FROM "TCA"."BETA_TCAOutputresults" outbnd  -- to be changed to a view over the STORE table if hostory is required
					FULL OUTER JOIN "dbo"."T_TCA_ITG_RESPONSE_ALLOCATIONS_DEAGGREGATED" inbnd
					ON  outbnd.AllocationDateTime = inbnd.origTradeDateTime
						AND	outbnd.ParentOrderID = inbnd.OrderId
						AND outbnd.OrderId = inbnd.Child_Order_Id
						AND outbnd.Symbol = inbnd.Symbol 
						AND outbnd.Account = inbnd.Account 
						AND outbnd.BrokerID = inbnd.Broker 
					LEFT OUTER JOIN (SELECT DISTINCT ParentOrderID, OrderId FROM "TCA"."BETA_TCAOutputresults") cur
					ON inbnd.OrderId = cur.ParentOrderID
						AND inbnd.Child_Order_Id = cur.OrderId
				)
SELECT	*, 
		CASE	WHEN [ITG_Decision_Date_Matched?] = 0 
					OR  [ITG_Parent_Order_ID_Matched?] = 0 
					OR  [ITG_Child_Order_ID_Matched?] = 0 
					OR  [ITG_Symbol_Matched?] = 0 
					OR  [ITG_Ticker_Matched?] = 0 
					OR  [ITG_Side_Matched?] = 0 
					OR  [ITG_Broker_Matched?] = 0 
					OR  [ITG_Total_Order_Size_Matched?] = 0 
					OR  [ITG_Shares_Matched?] = 0 
					OR  [ITG_Price_Matched?] = 0 
					OR  [ITG_Account_Matched?] = 0 
					OR  [ITG_Broker_Commission_Matched?] = 0 
					OR  [ITG_Dividend_Matched?] = 0 
					OR  [ITG_Special_Dividend_Matched?] = 0 
					OR  [ITG_Reason_Code_Matched?] = 0 
		THEN 
					CASE WHEN To_ITG_Parent_Order_ID IS NULL THEN 'Missing TCA Sent Record'
						 WHEN From_ITG_Parent_Order_ID IS NULL THEN 'Missing ITG Record'
						 ELSE
							IIF([ITG_Decision_Date_Matched?] = 0,'Decision_Date Mismatch,','')  + 
							IIF([ITG_Parent_Order_ID_Matched?] = 0, 'Parent_Order_ID Mismatch,','') +  
							IIF([ITG_Child_Order_ID_Matched?] = 0, 'Child_Order_ID Mismatch,','') +   
							IIF([ITG_Symbol_Matched?] = 0, 'Symbol Mismatch,','') +   
							IIF([ITG_Ticker_Matched?] = 0, 'Ticker Mismatch,','') +   
							IIF([ITG_Side_Matched?] = 0, 'Side Mismatch,','') +   
							IIF([ITG_Broker_Matched?] = 0, 'Broker Mismatch,','') +   
							IIF([ITG_Total_Order_Size_Matched?] = 0, 'Total_Order_Size Mismatch,','') +   
							IIF([ITG_Shares_Matched?] = 0, 'Shares Mismatch,','') +   
							IIF([ITG_Price_Matched?] = 0, 'Price Mismatch,','') +   
							IIF([ITG_Account_Matched?] = 0, 'Account Mismatch,','') +   
							IIF([ITG_Broker_Commission_Matched?] = 0, 'Broker_Commission Mismatch,','') +   
							IIF([ITG_Dividend_Matched?] = 0, 'Dividend Mismatch,','') +   
							IIF([ITG_Special_Dividend_Matched?] = 0, 'Special_Dividend Mismatch,','') +   
							IIF([ITG_Reason_Code_Matched?] = 0, 'Reason_Code Mismatch,','')
						END
					ELSE 'Matched'
		END AS Mismatch_Message
FROM CTE_REC

