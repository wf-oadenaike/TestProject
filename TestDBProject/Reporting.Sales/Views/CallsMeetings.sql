

CREATE VIEW [Reporting.Sales].[CallsMeetings]
	AS
  WITH LatestMarketShare_CTE as
	( 
	   SELECT  SUM(ISNULL(fc.[UK_Equity_Income_Own_Gross_Sales],0)) AS [OwnSalesGross]
             , SUM(ISNULL(fc.[UK_Equity_Income_Market_Gross_Sales],0)) AS [MarketSalesGross]
	         , fc.[SalesforceAccountId]
	   FROM [Sales].[FinancialClarity] fc
	   INNER JOIN (SELECT  cal.[FiscalFirstDayOfQuarter]
		                 , cal.[FiscalLastDayOfQuarter]
		                 , mfc.MaxDate as LatestDate
	               FROM (SELECT MAX([As_at_Date]) as MaxDate 
	               FROM [Sales].[FinancialClarity]) mfc
	               INNER JOIN [Core].[Calendar] cal
	               ON mfc.MaxDate = cal.[CalendarDate] ) lq
	   ON fc.[As_at_Date] BETWEEN lq.[FiscalFirstDayOfQuarter] AND lq.[FiscalLastDayOfQuarter]
	   GROUP BY fc.[SalesforceAccountId]
	)
	
  SELECT  
	   p.PersonsName AS Salesperson
	  ,p.PersonId AS SalespersonId
	  ,acc.[AccountName] AS Account
      ,f.ActivityDate AS EventDate
	  ,'Planned' AS PlannedActual
	  ,acc.[IsPriorityClient] AS IsPriorityClient
	  ,f.[Description] AS Note
      ,r.[RegionName] AS RegionName
	  ,acc.[CalculatedPriority] AS PriorityRank
	  ,pr.[PriorityRankNew] as PriorityRankNew
      ,acc.[IsKeyAccount] AS IsKeyAccount
      ,CASE WHEN lms.[MarketSalesGross] = 0 THEN 0 ELSE lms.[OwnSalesGross]/ lms.[MarketSalesGross] *100 END AS LastQuarterEquityIncomeMarketShare
--    ,mr.[ActivityName] AS Market
	  ,f.[Type] AS EventType
      ,f.Status AS [Status]

  FROM 
		[Sales.BP].[Forecast] f
		INNER JOIN
		[Sales.BP].[SfAccountVw] acc ON acc.SfAccountId = f.AccountId
		INNER JOIN
		[Core].[Persons] p ON p.[FullEmployeeBK]  = f.[OwnerId] 
		INNER JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
		LEFT OUTER JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = acc.[RegionId]
--		LEFT JOIN
--		[Sales.BP].[MarketActivity] mr ON mr.[AccountId] = acc.[AccSalesforceId] AND mr.QuarterOrder = 1 AND mr.IsActive = 1
		LEFT OUTER JOIN 
		[Sales.BP].[WoodfordAccountPriorityRank] pr ON acc.[SfAccountId] = pr.[AccSalesforceId]
		LEFT OUTER JOIN
		LatestMarketShare_CTE lms ON acc.SfAccountId = lms.[SalesforceAccountId] collate SQL_Latin1_General_CP1_CS_AS
		WHERE f.IsActive = 1
		AND p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	    AND d.DepartmentName = 'Sales - Retail'
UNION ALL
  SELECT  
	  p.PersonsName AS Salesperson
	  ,p.PersonId AS SalespersonId
	  ,acc.[AccountName] AS Account
      ,a.ActivityDate AS EventDate
	  ,'Actual' AS PlannedActual
	  ,acc.[IsPriorityClient] AS IsPriorityClient
	  ,a.[Description] AS Note
      ,r.[RegionName] AS RegionName
	  ,acc.[CalculatedPriority] AS PriorityRank
	  ,pr.[PriorityRankNew] as PriorityRankNew
      ,acc.[IsKeyAccount] AS IsKeyAccount
      ,CASE WHEN lms.[MarketSalesGross] = 0 THEN 0 ELSE lms.[OwnSalesGross]/ lms.[MarketSalesGross] *100 END AS LastQuarterEquityIncomeMarketShare
--    ,mr.[ActivityName] AS Market
	  ,a.[Type] AS EventType
      ,a.Status AS [Status]
  FROM 
		[Sales.BP].[Actual] a
		INNER JOIN
		[Sales.BP].[SfAccountVw] acc ON acc.SfAccountId = a.AccountId
		INNER JOIN
		[Core].[Persons] p ON p.[FullEmployeeBK]  = a.[OwnerId]
		INNER JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
		LEFT OUTER JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = acc.[RegionId]
--		LEFT JOIN
--		[Sales.BP].[MarketActivity] mr ON mr.[AccountId] = a.[AccountId] AND mr.QuarterOrder = 1 AND mr.IsActive = 1
		LEFT OUTER JOIN 
		[Sales.BP].[WoodfordAccountPriorityRank] pr ON acc.[SfAccountId] = pr.[AccSalesforceId]
		LEFT OUTER JOIN
		LatestMarketShare_CTE lms ON acc.SfAccountId = lms.[SalesforceAccountId] collate SQL_Latin1_General_CP1_CS_AS
		WHERE  a.IsActive = 1
		AND p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	    AND d.DepartmentName = 'Sales - Retail'
/*
UNION
  SELECT  
	  p.PersonsName AS Salesperson
	  ,p.PersonId AS SalespersonId
	  ,acc.[AccName] AS Account
      ,a.ActivityDate AS EventDate
	  ,'Actual' AS PlannedActual
	  ,acc.[AccIsPriorityClient] AS IsPriorityClient
	  ,a.[Description] AS Note
      ,r.[RegionName] AS RegionName
	  ,acc.[AccCalculatedPriority] AS PriorityRank
	  ,pr.[PriorityRankNew] as PriorityRankNew
      ,acc.[AccIsKeyAccount] AS IsKeyAccount
      ,acc.[AccLastQUKEquityIncomeMarketShare] AS LastQuarterEquityIncomeMarketShare
      ,mr.[ActivityName] AS Market
	  ,a.[Type] AS EventType
      ,a.Status AS [Status]
  FROM 
		[Sales.BP].[Actual] a
		INNER JOIN
		[Sales.BP].[ActualAttendee] aa ON left(aa.ActualId,15) = a.ActualId  collate SQL_Latin1_General_CP1_CS_AS
		or aa.ActualId  = a.ActualId  collate SQL_Latin1_General_CP1_CS_AS
		INNER JOIN
		[Sales.BP].[WoodfordContact] c on c.CntSalesforceId = aa.ContactId
		INNER JOIN
		[Sales.BP].[WoodfordAccountContact] ac ON c.Id = ac.ContactId 
		LEFT JOIN
		[Core].[Persons] p ON  p.[FullEmployeeBK]  = a.[OwnerId]
		LEFT JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
		INNER JOIN
		[Sales.BP].[WoodfordAccount] acc ON acc.Id = ac.AccountId 		
		LEFT JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = acc.[RegionId]
		LEFT JOIN
		[Sales.BP].[MarketActivity] mr ON mr.[AccountId] = acc.[AccSalesforceId] AND mr.QuarterOrder = 1 AND mr.IsActive = 1  
		LEFT OUTER JOIN 
		[Contacts].[WoodfordAccountPriorityRank] pr ON acc.[AccSalesforceId] = pr.[AccSalesforceId]
		WHERE ISNULL(mr.IsActive,0) = 1  
		AND a.AccountId IS NULL
		AND a.IsActive = 1 AND aa.IsActive = 1 AND acc.IsActive = 'Y' 
		AND p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	    AND d.DepartmentName = 'Sales - Retail'
*/
;





