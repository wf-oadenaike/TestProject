
CREATE VIEW [Reporting.Investment].[CallsMeetingsAttendees]
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
	  ,[AccountName] AS Account
      ,a.ActivityDate AS EventDate
	  ,'Actual' AS PlannedActual
	  ,acc.[IsPriorityClient] AS IsPriorityClient
	  ,a.[Description] AS Note
      ,[RegionName] AS RegionName
      ,acc.[CalculatedPriority] AS PriorityRank
      ,acc.[IsKeyAccount] AS IsKeyAccount
	  ,CASE WHEN lms.[MarketSalesGross] = 0 THEN 0 ELSE lms.[OwnSalesGross]/ lms.[MarketSalesGross] *100 END AS LastQuarterEquityIncomeMarketShare
    --  ,[ActivityName] AS Market
	  ,a.[Type] AS EventType
      ,a.Status AS [Status]
  FROM 
		[Sales.BP].[Actual] a
		INNER JOIN
		[Sales.BP].[ActualAttendee] aa ON aa.ActualId = a.ActualId
		INNER JOIN
		[Sales.BP].[SfContactVw] c on c.SfContactId = aa.ContactId
		INNER JOIN
		[Core].[Persons] p ON p.[FullEmployeeBK] = a.[OwnerId]
		INNER JOIN 
		[Core].[Departments] d ON p.[DepartmentId] = d.[DepartmentId]
		INNER JOIN
		[Sales.BP].[SfAccountVw] acc ON acc.SfAccountId = c.SfAccountId
		LEFT OUTER JOIN
		[Sales.BP].[Region] r ON r.[RegionId] = acc.[RegionId]
	--	LEFT JOIN
	--	[Sales.BP].[MarketActivity] mr ON mr.[AccountId] = acc.[AccSalesforceId] AND mr.QuarterOrder = 1
		LEFT OUTER JOIN
		LatestMarketShare_CTE lms ON  acc.SfAccountId = lms.[SalesforceAccountId] collate SQL_Latin1_General_CP1_CS_AS
		WHERE --ISNULL(mr.IsActive,0) = 1  
		--AND a.AccountId IS NULL
		 a.IsActive = 1 AND aa.IsActive = 1
		AND p.[ActiveFlag] = 1 AND d.[ActiveFlag] = 1
	    AND d.DepartmentName = 'Investment'
  
;

