
/****** Object:  UserDefinedFunction [ETL].[up_NETMarginVW_2]    Script Date: 04/08/2016 08:30:37 ******/
-- =============================================
-- Author:		Joe Tapper
-- Create date: 2016-08-04
-- Description:	Calculates a progressive totals
-- for the fiscal year parameter
-- used to show numerator and denominator values
-- =============================================
CREATE FUNCTION [ETL].[up_NETMargin_2] 
(
	-- Add the parameters for the function here
	@fiscalYear int
	
)
RETURNS 
@KPIData TABLE 
(
	-- Add the column definitions for the TABLE variable here
	--KPIDataDate int,
	--Actual Decimal(10,5)
	--Target int,
	--LastUpdatedDate datetime


	KPIDataDate int,
		numerator money,
		demoninator money,
		target int,
		LastUpdatedDate datetime

		
)
AS
BEGIN
	Declare @t1 table 
		(
		KPIDataDate int,
		numerator money,
		denominator money,
		target int,
		LastUpdatedDate datetime
		)
	Declare @t2 table 
		(
		KPIDataDate int,
		numerator money,
		denominator money,
		target int,
		LastUpdatedDate datetime
		)

;WITH DiscretionaryForcastsFix_CTE AS
(
	SELECT d.FinancialFactId, (CASE WHEN ISNULL(ABS(d.BudgetAmount),0) - ISNULL(ABS(n.BudgetAmount),0) < 0 THEN 0 ELSE ISNULL(ABS(d.BudgetAmount),0) - ISNULL(ABS(n.BudgetAmount),0) END) AS [Difference]
	  FROM [Fact].[FinancialsFact] d
	  LEFT JOIN [Fact].[FinancialsFact] n ON 
	  d.DepartmentId = n.DepartmentId 
	  AND d.TransactionDateId = n.TransactionDateId 
	  --AND d.BudgetAmount = n.BudgetAmount
	  AND n.NominalCode = d.NominalCode
	  AND n.CurrentRow = 1 
	  AND n.DeletedRow = 0 
	  AND n.FinancialLineTypeId = 8
	  WHERE d.FinancialLineTypeId = 7 AND d.CurrentRow = 1 AND d.DeletedRow = 0
	  --AND n.FinancialFactId IS NULL 
	  --AND d.BudgetAmount <> 0
)



--Load up the first set of sums

	insert into @t1
	SELECT format(transactionDate,'yyyyMM')as KPIDataDate
      ,sum(case when NominalCode >=4000 then [AmountRaw] else 0 end) as numerator
	  ,sum(case when NominalCode >=4000 and NominalCode<4300 then AmountRaw else 0 end) as denominator
	  ,0 as Target
	  ,format(LastDayOfMonth,'yyyy-MM-ddT00:00:00') as LastUpdatedDate
  FROM(
SELECT 
		f.FinancialFactId
		,c.FiscalYear
		,c.FiscalFirstDayOfYear
		,c.FiscalLastDayOfYear
		--,c.ExpenseReportingFiscalYear AS FiscalYear
		--,c.ExpenseReportingFiscalFirstDayOfYear AS FiscalFirstDayOfYear
		--,c.ExpenseReportingFiscalLastDayOfYear AS FiscalLastDayOfYear
		,d.DepartmentNumber
		,d.DepartmentName
		,c.CalendarDate AS TransactionDate
		,SUBSTRING(DetailNotes, CHARINDEX(':', DetailNotes, CHARINDEX(':', DetailNotes, 1) + 1) + 2,  LEN(DetailNotes) - CHARINDEX(':', DetailNotes, CHARINDEX(':', DetailNotes, 1) + 1) + 2) AS Details
		,(CASE WHEN f.[NominalCode] = 7001 AND flt.[FinancialLineCode] = 'A' AND DetailNotes LIKE '%Payroll%' AND 
			Month(c.CalendarDate) IN (6,7,10,1) THEN 
		f.ActualAmount
		WHEN f.[NominalCode] <> 7001 AND flt.[FinancialLineCode] = 'A' THEN f.ActualAmount
		WHEN flt.[FinancialLineCode] = 'P' THEN f.ActualAmount
		END) AS Amount
		-- FOR 20152016 year, the discretionary forecast includes the non-discretionary.  After 20152016 both values are separate
		,(CASE WHEN flt.[FinancialLineCode] = 'FD' AND c.FiscalYear = 20152016 THEN COALESCE(cte.[difference], f.BudgetAmount) ELSE
		f.BudgetAmount END) AS Forecast
		,f.TransactionNo
		,anc.AccountName
		,ac.AccountCategory
		,tt.TransactionTypeBK
		, sup.Supplier
		, f.NominalCode
		, flt.FinancialLineCode
		, proj.ProjectName
		, (CASE 
			WHEN f.NominalCode = 7001 THEN 1 
			WHEN flt.FinancialLineCode = 'A' THEN ISNULL(f.IsDiscretionary,0)
			WHEN flt.FinancialLineCode = 'FD' AND cte.difference > 0 AND c.FiscalYear = 20152016 THEN 1
			WHEN flt.FinancialLineCode = 'FD' AND cte.difference <= 0 AND c.FiscalYear = 20152016 THEN 0
			WHEN flt.FinancialLineCode = 'FD' AND c.FiscalYear <> 20152016 THEN 1
			ELSE 0
			END) 
			AS IsDiscretionary
		, (CASE 
			WHEN f.NominalCode = 7001 THEN 0 
			WHEN flt.FinancialLineCode = 'FN' THEN 1
			WHEN flt.FinancialLineCode = 'FD' AND cte.difference <= 0 AND c.FiscalYear = 20152016 THEN 1
			WHEN flt.FinancialLineCode = 'A'  THEN 1 - ISNULL(f.IsDiscretionary,0)
			ELSE 0
			END) AS IsNonDiscretionary
		, f.ActualAmount AS [AmountRaw]
		,CONVERT(DATETIME, LEFT(f.ControlId, 8), 112) AS ControlDate
			FROM Fact.FinancialsFact f
			INNER JOIN Finance.FinancialLineTypes flt
				ON (f.FinancialLineTypeId = flt.FinancialLineTypeId)
				INNER JOIN Core.Departments d
					ON f.DepartmentId = d.DepartmentId
				INNER JOIN Core.Calendar c
					ON f.TransactionDateId = c.CalendarId
				INNER JOIN Finance.AccountNominalCodes anc
					ON f.NominalCode = anc.NominalCode
				LEFT JOIN Finance.AccountCategories ac
					ON anc.AccountCategoryId = ac.AccountCategoryId
				LEFT JOIN Finance.AccountSuppliers sup 
					ON sup.AccountRef = f.AccountRef
				LEFT JOIN Finance.TransactionTypes tt
					ON f.TransactionTypeId = tt.TransactionTypeId
				LEFT JOIN Finance.AccountProjects proj
					ON f.ProjectCode = proj.ProjectCode
				LEFT JOIN DiscretionaryForcastsFix_CTE cte ON
					cte.FinancialFactId = f.FinancialFactId
			WHERE f.CurrentRow = 1
			AND f.DeletedRow = 0 ) vw
join 
  Core.Calendar C on C.CalendarDate=format(transactionDate,'yyyy-MM-dd 00:00:00')
  where financiallinecode='A'
  and nominalcode>=4000
  and C.FiscalYear=@fiscalYear
  group by format(transactionDate,'yyyyMM'),format(LastDayOfMonth,'yyyy-MM-ddT00:00:00')


  insert into @t2 select * from @t1

 
 insert into @KPIData
  select t1.KPIDataDate, SUM(t2.numerator) as progressive_numerator, sum(t2.denominator) as progressive_denominator, 
  t1.target, t1.LastUpdatedDate
from @t1 t1
inner join @t2 t2 on t1.KPIDataDate >= t2.KPIDataDate
group by t1.KPIDataDate, t1.target,t1.LastUpdatedDate
order by t1.KPIDataDate

	-- Fill the table variable with the rows for your result set
	
	RETURN 
END
