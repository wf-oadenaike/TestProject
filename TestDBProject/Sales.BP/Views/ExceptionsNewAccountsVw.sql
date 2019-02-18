

CREATE VIEW [Sales.BP].[ExceptionsNewAccountsVw] AS

-------------------------------------------------------------------------------------- 
-- Name: New Accounts View - [Sales.BP].[ExceptionsNewAccountsVw]
-- Object: View

-- 
-------------------------------------------------------------------------------------- 
-- History:
-- WHO WHEN WHY
-- Fari Sharifi, 10/06/2017 Reads New accounts from the Matrix and Salesforce account tables
-- Richard Dixon 05/10/2017 Amended to now return 12-monthly totals
-- Vipul Khatri	 24/04/2018	 Changed code to use new Matrix tables.
-- Vipul Khatri	 11/05/2018  Added AccountSivID so that we can map SFAccountID on load to salesforce.
-------------------------------------------------------------------------------------- 



WITH fc
     AS (
          SELECT Matrix_Outlet_ID,
                 SUM([Outlet_Own_Gross_Sales])              AS "Outlet_Own_Gross_Sales",
                 SUM([Outlet_Market_Gross_Sales])           AS "Outlet_Market_Gross_Sales",
                 SUM([UK_Equity_Income_Own_Gross_Sales])    AS "UK_Equity_Income_Own_Gross_Sales",
                 SUM([UK_Equity_Income_Market_Gross_Sales]) AS "UK_Equity_Income_Market_Gross_Sales",
                 SUM([Specialist_Own_Gross_Sales])          AS "Specialist_Own_Gross_Sales",
                 SUM([Specialist_Market_Gross_Sales])       AS "Specialist_Market_Gross_Sales",
                 MIN(AS_at_Date)                            AS FC_From_Date,
                 MAX(AS_at_Date)                            AS FC_To_Date
          FROM [Sales].[FinancialClarity]
          WHERE AS_at_Date >= DATEADD(yy, -1, (
               SELECT MAX(As_at_Date)
               FROM [Sales].[FinancialClarity]
          )
          )
          GROUP BY Matrix_Outlet_ID
     )

SELECT mx.AccountName                             AS Accountname,
       mx.FcaId                                   AS AccountFcaId,
       mx.MatrixOutletId                          AS matrix_outlet_id,
       ISNULL(mx.AccountOwnerId, 'UNKNOWN OWNER') AS AccountOwnerId,
       mx.BillingCity                             AS BillingCity,
       mx.BillingPostcode                         AS BillingPostCode,
       fc.[Outlet_Own_Gross_Sales]                AS "Total Account Sales",
       fc.[Outlet_Market_Gross_Sales]             AS "Total Market Sales",
       fc.[UK_Equity_Income_Own_Gross_Sales]      AS "Equity Income Account Sales",
       fc.[UK_Equity_Income_Market_Gross_Sales]   AS "Equity Income Market Sales",
       fc.[Specialist_Own_Gross_Sales]            AS "Specialist Sector Account Sales",
       fc.[Specialist_Market_Gross_Sales]         AS "Specialist Sector Market Sales",
       FC_From_Date,
       FC_To_Date,
	   mx.AccountSivId

FROM [Sales.BP].[MxAccountVw] mx
LEFT OUTER JOIN fc
     ON mx.MatrixOutletId = fc.matrix_outlet_id
WHERE mx.SfAccountId = ''
--AND  	mx.isactive = 1 -- ?? how is this derived
-- Only select what has been inserted and has FC data
--AND		mx.LastModifiedDatetime = (select min(LastModifiedDatetime)FROM [Sales.BP].[MxAccount] WHERE sfAccountId IS NULL AND isactive = 1)  --??