CREATE VIEW [Reporting].[FinanceSummaryCompensationVw]
AS
SELECT 
	c.FiscalYear
	,c.CalYear AS Year
	,RIGHT('0' + CONVERT(VARCHAR(2), c.CalMonth),2) AS Month
	,c.CalYYYYMM AS YearMonth
      ,[NominalCode]
      ,SUM(ActualAmount) AS Amount
  FROM [Fact].[FinancialsFact] f 
  INNER JOIN [core].[calendar] c ON f.TransactionDateId = c.CalendarId
  WHERE NominalCode IN (
  7001, 7006, 7000
  ) AND DeletedRow = 0 AND [currentRow] = 1
  GROUP BY NominalCode, c.FiscalYear, c.CalYear, c.CalYYYYMM, c.CalMonth
