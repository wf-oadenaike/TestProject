CREATE PROCEDURE [Sales].[usp_MergeFinancialClarityData]
	
AS
	MERGE INTO [Sales].[FinancialClarity] Tar
	USING (SELECT DISTINCT
		CONVERT(DATE,[As_at_Date],103) AS [As_at_Date]
      ,[MTX_ACCOUNT_SIV_ID]
      ,LTRIM(RTRIM([Matrix_Outlet_ID])) AS [Matrix_Outlet_ID]
	  , om.AccSalesforceId AS SalesforceAccountId
      ,CONVERT(DECIMAL(18,2),[Outlet_Own_Gross_Sales]) AS [Outlet_Own_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[Outlet_Market_Gross_Sales]) AS [Outlet_Market_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[Outlet_Own_Net_Sales]) AS [Outlet_Own_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[Outlet_Market_Net_Sales]) AS [Outlet_Market_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_Income_Own_Gross_Sales]) AS [UK_Equity_Income_Own_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_Income_Market_Gross_Sales]) AS [UK_Equity_Income_Market_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_Income_Own_Net_Sales]) AS [UK_Equity_Income_Own_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_Income_Market_Net_Sales]) AS [UK_Equity_Income_Market_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_and_Bond_Income_Own_Gross_Sales]) AS [UK_Equity_and_Bond_Income_Own_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_and_Bond_Income_Market_Gross_Sales]) AS [UK_Equity_and_Bond_Income_Market_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_and_Bond_Income_Own_Net_Sales]) AS [UK_Equity_and_Bond_Income_Own_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_Equity_and_Bond_Income_Market_Net_Sales]) AS [UK_Equity_and_Bond_Income_Market_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_All_Companies_Own_Gross_Sales]) AS [UK_All_Companies_Own_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_All_Companies_Market_Gross_Sales]) AS [UK_All_Companies_Market_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[UK_All_Companies_Own_Net_Sales]) AS [UK_All_Companies_Own_Net_Sales]	
	   ,CONVERT(DECIMAL(18,2),[UK_All_Companies_Market_Net_Sales]) AS [UK_All_Companies_Market_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[Global_Equity_Income_Own_Gross_Sales]) AS [Global_Equity_Income_Own_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[Global_Equity_Income_Market_Gross_Sales]) AS [Global_Equity_Income_Market_Gross_Sales]
       ,CONVERT(DECIMAL(18,2),[Global_Equity_Income_Own_Net_Sales]) AS [Global_Equity_Income_Own_Net_Sales]
       ,CONVERT(DECIMAL(18,2),[Global_Equity_Income_Market_Net_Sales]) AS [Global_Equity_Income_Market_Net_Sales]
	   ,CONVERT(DECIMAL(18,2),[Specialist_Own_Gross_Sales]) AS [Specialist_Own_Gross_Sales]
	   ,CONVERT(DECIMAL(18,2),[Specialist_Market_Gross_Sales]) AS [Specialist_Market_Gross_Sales]
	   ,CONVERT(DECIMAL(18,2),[Specialist_Own_Net_Sales]) AS [Specialist_Own_Net_Sales]
	   ,CONVERT(DECIMAL(18,2),[Specialist_Market_Net_Sales]) AS [Specialist_Market_Net_Sales]
  FROM [Staging.Matrix].[FinancialClarity] fc
  LEFT JOIN [Sales.BP].[WoodfordAccount] om ON om.accmatrixoutletid = LTRIM(RTRIM([Matrix_Outlet_ID])) and om.IsActive = 1 
		) Src
	ON tar.[As_at_Date] = Src.[As_at_Date] AND tar.[Matrix_Outlet_ID] = src.[Matrix_Outlet_ID] 
	WHEN NOT MATCHED
		THEN INSERT (
		[As_at_Date]
      ,[MTX_ACCOUNT_SIV_ID]
      ,[Matrix_Outlet_ID]
      ,[SalesforceAccountId]
      ,[Outlet_Own_Gross_Sales]
      ,[Outlet_Market_Gross_Sales]
      ,[Outlet_Own_Net_Sales]
      ,[Outlet_Market_Net_Sales]
      ,[UK_Equity_Income_Own_Gross_Sales]
      ,[UK_Equity_Income_Market_Gross_Sales]
      ,[UK_Equity_Income_Own_Net_Sales]
      ,[UK_Equity_Income_Market_Net_Sales]
      ,[UK_Equity_and_Bond_Income_Own_Gross_Sales]
      ,[UK_Equity_and_Bond_Income_Market_Gross_Sales]
      ,[UK_Equity_and_Bond_Income_Own_Net_Sales]
      ,[UK_Equity_and_Bond_Income_Market_Net_Sales]
      ,[UK_All_Companies_Own_Gross_Sales]
      ,[UK_All_Companies_Market_Gross_Sales]
      ,[UK_All_Companies_Own_Net_Sales]	
	  ,[UK_All_Companies_Market_Net_Sales]
      ,[Global_Equity_Income_Own_Gross_Sales]
      ,[Global_Equity_Income_Market_Gross_Sales]
      ,[Global_Equity_Income_Own_Net_Sales]
      ,[Global_Equity_Income_Market_Net_Sales]
	  ,[Specialist_Own_Gross_Sales]
	  ,[Specialist_Market_Gross_Sales]
	  ,[Specialist_Own_Net_Sales]
	  ,[Specialist_Market_Net_Sales]
	  
		)
		     VALUES (
			 [As_at_Date]
      ,src.[MTX_ACCOUNT_SIV_ID]
      ,[Matrix_Outlet_ID]
      ,src.[SalesforceAccountId]
      ,[Outlet_Own_Gross_Sales]
      ,[Outlet_Market_Gross_Sales]
      ,[Outlet_Own_Net_Sales]
      ,[Outlet_Market_Net_Sales]
      ,[UK_Equity_Income_Own_Gross_Sales]
      ,[UK_Equity_Income_Market_Gross_Sales]
      ,[UK_Equity_Income_Own_Net_Sales]
      ,[UK_Equity_Income_Market_Net_Sales]
      ,[UK_Equity_and_Bond_Income_Own_Gross_Sales]
      ,[UK_Equity_and_Bond_Income_Market_Gross_Sales]
      ,[UK_Equity_and_Bond_Income_Own_Net_Sales]
      ,[UK_Equity_and_Bond_Income_Market_Net_Sales]
      ,[UK_All_Companies_Own_Gross_Sales]
      ,[UK_All_Companies_Market_Gross_Sales]
      ,[UK_All_Companies_Own_Net_Sales]
	  ,[UK_All_Companies_Market_Net_Sales]
      ,[Global_Equity_Income_Own_Gross_Sales]
      ,[Global_Equity_Income_Market_Gross_Sales]
      ,[Global_Equity_Income_Own_Net_Sales]
      ,[Global_Equity_Income_Market_Net_Sales]
	  ,[Specialist_Own_Gross_Sales]
	  ,[Specialist_Market_Gross_Sales]
	  ,[Specialist_Own_Net_Sales]
	  ,[Specialist_Market_Net_Sales]
	  )
	WHEN MATCHED AND (ISNULL(tar.[SalesforceAccountId],'ABCDE') <> ISNULL(Src.[SalesforceAccountId],'ABCDE'))
			OR (ISNULL(tar.[Outlet_Own_Gross_Sales], -99999) <> ISNULL(Src.[Outlet_Own_Gross_Sales], -99999))
      OR (ISNULL(tar.[Outlet_Market_Gross_Sales], -99999) <> ISNULL(Src.[Outlet_Market_Gross_Sales], -99999))
      OR (ISNULL(tar.[Outlet_Own_Net_Sales], -99999) <> ISNULL(Src.[Outlet_Own_Net_Sales], -99999))
      OR (ISNULL(tar.[Outlet_Market_Net_Sales], -99999) <> ISNULL(Src.[Outlet_Market_Net_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_Income_Own_Gross_Sales], -99999) <> ISNULL(Src.[UK_Equity_Income_Own_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_Income_Market_Gross_Sales], -99999) <> ISNULL(Src.[UK_Equity_Income_Market_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_Income_Own_Net_Sales], -99999) <> ISNULL(Src.[UK_Equity_Income_Own_Net_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_Income_Market_Net_Sales], -99999) <> ISNULL(Src.[UK_Equity_Income_Market_Net_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_and_Bond_Income_Own_Gross_Sales], -99999) <> ISNULL(Src.[UK_Equity_and_Bond_Income_Own_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_and_Bond_Income_Market_Gross_Sales], -99999) <> ISNULL(Src.[UK_Equity_and_Bond_Income_Market_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_and_Bond_Income_Own_Net_Sales], -99999) <> ISNULL(Src.[UK_Equity_and_Bond_Income_Own_Net_Sales], -99999))
      OR (ISNULL(tar.[UK_Equity_and_Bond_Income_Market_Net_Sales], -99999) <> ISNULL(Src.[UK_Equity_and_Bond_Income_Market_Net_Sales], -99999))
      OR (ISNULL(tar.[UK_All_Companies_Own_Gross_Sales], -99999) <> ISNULL(Src.[UK_All_Companies_Own_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_All_Companies_Market_Gross_Sales], -99999) <> ISNULL(Src.[UK_All_Companies_Market_Gross_Sales], -99999))
      OR (ISNULL(tar.[UK_All_Companies_Own_Net_Sales], -99999) <> ISNULL(Src.[UK_All_Companies_Own_Net_Sales], -99999))
	  OR (ISNULL(tar.[UK_All_Companies_Market_Net_Sales], -99999) <> ISNULL(Src.[UK_All_Companies_Market_Net_Sales], -99999))
      OR (ISNULL(tar.[Global_Equity_Income_Own_Gross_Sales], -99999) <> ISNULL(Src.[Global_Equity_Income_Own_Gross_Sales], -99999))
      OR (ISNULL(tar.[Global_Equity_Income_Market_Gross_Sales], -99999) <> ISNULL(Src.[Global_Equity_Income_Market_Gross_Sales], -99999))
      OR (ISNULL(tar.[Global_Equity_Income_Own_Net_Sales], -99999) <> ISNULL(Src.[Global_Equity_Income_Own_Net_Sales], -99999))
      OR (ISNULL(tar.[Global_Equity_Income_Market_Net_Sales], -99999) <> ISNULL(Src.[Global_Equity_Income_Market_Net_Sales], -99999))
	  OR (ISNULL(tar.[Specialist_Own_Gross_Sales], -99999) <> ISNULL(Src.[Specialist_Own_Gross_Sales], -99999))
	  OR (ISNULL(tar.[Specialist_Market_Gross_Sales], -99999) <> ISNULL(Src.[Specialist_Market_Gross_Sales], -99999))
	  OR (ISNULL(tar.[Specialist_Own_Net_Sales], -99999) <> ISNULL(Src.[Specialist_Own_Net_Sales], -99999))
	  OR (ISNULL(tar.[Specialist_Market_Net_Sales], -99999) <> ISNULL(Src.[Specialist_Market_Net_Sales], -99999))
	  THEN UPDATE SET 
	  tar.[SalesforceAccountId] = Src.[SalesforceAccountId]
      ,tar.[Outlet_Own_Gross_Sales] = Src.[Outlet_Own_Gross_Sales]
      ,tar.[Outlet_Market_Gross_Sales] = Src.[Outlet_Market_Gross_Sales]
      ,tar.[Outlet_Own_Net_Sales] = Src.[Outlet_Own_Net_Sales]
      ,tar.[Outlet_Market_Net_Sales] = Src.[Outlet_Market_Net_Sales]
      ,tar.[UK_Equity_Income_Own_Gross_Sales] = Src.[UK_Equity_Income_Own_Gross_Sales]
      ,tar.[UK_Equity_Income_Market_Gross_Sales] = Src.[UK_Equity_Income_Market_Gross_Sales]
      ,tar.[UK_Equity_Income_Own_Net_Sales] = Src.[UK_Equity_Income_Own_Net_Sales]
      ,tar.[UK_Equity_Income_Market_Net_Sales] = Src.[UK_Equity_Income_Market_Net_Sales]
      ,tar.[UK_Equity_and_Bond_Income_Own_Gross_Sales] = Src.[UK_Equity_and_Bond_Income_Market_Gross_Sales]
      ,tar.[UK_Equity_and_Bond_Income_Market_Gross_Sales] = Src.[UK_Equity_and_Bond_Income_Market_Gross_Sales]
      ,tar.[UK_Equity_and_Bond_Income_Own_Net_Sales] = Src.[UK_Equity_and_Bond_Income_Own_Net_Sales]
      ,tar.[UK_Equity_and_Bond_Income_Market_Net_Sales] = Src.[UK_Equity_and_Bond_Income_Market_Net_Sales]
      ,tar.[UK_All_Companies_Own_Gross_Sales] = Src.[UK_All_Companies_Own_Gross_Sales]
      ,tar.[UK_All_Companies_Market_Gross_Sales] = Src.[UK_All_Companies_Market_Gross_Sales]
      ,tar.[UK_All_Companies_Own_Net_Sales] = Src.[UK_All_Companies_Own_Net_Sales]
	  ,tar.[UK_All_Companies_Market_Net_Sales] = Src.[UK_All_Companies_Market_Net_Sales]
      ,tar.[Global_Equity_Income_Own_Gross_Sales] = Src.[Global_Equity_Income_Own_Gross_Sales]
      ,tar.[Global_Equity_Income_Market_Gross_Sales] = Src.[Global_Equity_Income_Market_Gross_Sales]
      ,tar.[Global_Equity_Income_Own_Net_Sales] = Src.[Global_Equity_Income_Own_Net_Sales]
      ,tar.[Global_Equity_Income_Market_Net_Sales] = Src.[Global_Equity_Income_Market_Net_Sales]
	  ,tar.[Specialist_Own_Gross_Sales]  = Src.[Specialist_Own_Gross_Sales]
	  ,tar.[Specialist_Market_Gross_Sales] = Src.[Specialist_Market_Gross_Sales]
	  ,tar.[Specialist_Own_Net_Sales] = Src.[Specialist_Own_Net_Sales]
	  ,tar.[Specialist_Market_Net_Sales] = Src.[Specialist_Market_Net_Sales]
	  ;

