CREATE VIEW [KPI].[DefaultKPIValueListVw]
	AS

	SELECT [KPIId]
      ,[GreenThresholdValue] AS DefaultValue
	  ,CONVERT(bigint, CONVERT(VARCHAR(4), DATEPART(yy, GETDATE())) + RIGHT('0'+ CONVERT(VARCHAR(2), DATEPART(MM, GETDATE())),2) + RIGHT('0' + CONVERT(VARCHAR(2), DATEPART(dd, GETDATE())),2)) AS DefaultDate
  FROM [KPI].[MeasuredKPIs]
  WHERE AggrFunction = 'AVG' AND [GreenThresholdValue] IS NOT NULL
