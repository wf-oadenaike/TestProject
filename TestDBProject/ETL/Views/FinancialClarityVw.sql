

CREATE VIEW [ETL].[FinancialClarityVw]
AS
SELECT CONVERT(VARCHAR(4),DATEPART(yy,[As_at_Date])) + '-' + RIGHT('0' + CONVERT(VARCHAR(2),DATEPART(mm,[As_at_Date])),2) + '-' + RIGHT('0' + CONVERT(VARCHAR(2),DATEPART(dd,[As_at_Date])),2) AS [As_at_Date]
      ,[MTX_ACCOUNT_SIV_ID]
      ,[Matrix_Outlet_ID]
      ,sfa.[SfAccountId] as [SalesforceAccountId]
      ,ISNULL([Outlet_Own_Gross_Sales],0) AS [Outlet_Own_Gross_Sales]
      ,ISNULL([Outlet_Market_Gross_Sales],0) AS [Outlet_Market_Gross_Sales]
      ,ISNULL([Outlet_Own_Net_Sales],0) AS [Outlet_Own_Net_Sales]
      ,ISNULL([Outlet_Market_Net_Sales],0) AS [Outlet_Market_Net_Sales]
      ,ISNULL([UK_Equity_Income_Own_Gross_Sales],0) AS [UK_Equity_Income_Own_Gross_Sales]
      ,ISNULL([UK_Equity_Income_Market_Gross_Sales],0) AS [UK_Equity_Income_Market_Gross_Sales]
      ,ISNULL([UK_Equity_Income_Own_Net_Sales],0) AS [UK_Equity_Income_Own_Net_Sales]
      ,ISNULL([UK_Equity_Income_Market_Net_Sales],0) AS [UK_Equity_Income_Market_Net_Sales]
      ,ISNULL([Specialist_Own_Gross_Sales],0) AS [Specialist_Own_Gross_Sales]
	  ,ISNULL([Specialist_Market_Gross_Sales],0) AS [Specialist_Market_Gross_Sales]
	  ,ISNULL([Specialist_Own_Net_Sales],0) AS [Specialist_Own_Net_Sales]
	  ,ISNULL([Specialist_Market_Net_Sales],0) AS [Specialist_Market_Net_Sales]
	  ,ISNULL([UK_Equity_and_Bond_Income_Own_Gross_Sales],0) AS [UK_Equity_and_Bond_Income_Own_Gross_Sales]
      ,ISNULL([UK_Equity_and_Bond_Income_Market_Gross_Sales],0) AS [UK_Equity_and_Bond_Income_Market_Gross_Sales]
      ,ISNULL([UK_Equity_and_Bond_Income_Own_Net_Sales],0) AS [UK_Equity_and_Bond_Income_Own_Net_Sales]
      ,ISNULL([UK_Equity_and_Bond_Income_Market_Net_Sales],0) AS [UK_Equity_and_Bond_Income_Market_Net_Sales]
      ,ISNULL([UK_All_Companies_Own_Gross_Sales],0) AS [UK_All_Companies_Own_Gross_Sales]
      ,ISNULL([UK_All_Companies_Market_Gross_Sales],0) AS [UK_All_Companies_Market_Gross_Sales]
      ,ISNULL([UK_All_Companies_Own_Net_Sales],0) AS [UK_All_Companies_Own_Net_Sales]
      ,ISNULL([UK_All_Companies_Market_Net_Sales],0) AS [UK_All_Companies_Market_Net_Sales]
      ,ISNULL([Global_Equity_Income_Own_Gross_Sales],0) AS [Global_Equity_Income_Own_Gross_Sales]
      ,ISNULL([Global_Equity_Income_Market_Gross_Sales],0) AS [Global_Equity_Income_Market_Gross_Sales]
      ,ISNULL([Global_Equity_Income_Own_Net_Sales],0) AS [Global_Equity_Income_Own_Net_Sales]
      ,ISNULL([Global_Equity_Income_Market_Net_Sales],0) AS [Global_Equity_Income_Market_Net_Sales]
	  ,MONTH([As_at_Date]) AS Month
      ,[CADIS_SYSTEM_INSERTED]
      ,[CADIS_SYSTEM_UPDATED]
      ,[CADIS_SYSTEM_CHANGEDBY]
      ,[CADIS_SYSTEM_PRIORITY]
      ,[CADIS_SYSTEM_TIMESTAMP]
      ,[CADIS_SYSTEM_LASTMODIFIED]
  FROM [Sales].[FinancialClarity] fc
  INNER JOIN [Sales.BP].[SfAccountVw] sfa
  ON fc.Matrix_Outlet_ID = sfa.MatrixOutletId
  WHERE 1=1
    -- Cadis_System_Inserted = (SELECT MAX(CADIS_SYSTEM_INSERTED) FROM [Sales].[FinancialClarity]) AND 
  AND sfa.[SfAccountId] IS NOT NULL