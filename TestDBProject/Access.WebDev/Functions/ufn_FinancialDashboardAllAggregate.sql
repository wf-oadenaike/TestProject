
CREATE FUNCTION [Access.WebDev].[ufn_FinancialDashboardAllAggregate]
(
    @FinancialYear INT = NULL 
)
-- RETURN Table Variable
RETURNS 
 @AggregateData TABLE
 (
[FinancialFactId] BIGINT  NULL,
[FiscalYear] INT,
[FiscalFirstDayOfYear] DATE,
[FiscalLastDayOfYear] DATE,
[DepartmentNumber] SMALLINT  NULL,
[DepartmentName] SYSNAME  NULL,
[TransactionDate]  VARCHAR(12)  NULL,
[Details] VARCHAR(4000),
[Amount] MONEY,
[Forecast] MONEY,
[TransactionNo] INT  NULL,
[AccountName] VARCHAR(128),
[AccountCategory] SYSNAME  NULL,
[TransactionTypeBK] CHAR(2)  NULL,
[Supplier] NVARCHAR(255)  NULL,
[NominalCode] INT  NULL,
[FinancialLineCode] VARCHAR(20)  NULL,
[ProjectName] VARCHAR(255)  NULL,
[IsDiscretionary] VARCHAR(2),
[IsNonDiscretionary] VARCHAR(2),
[AmountRaw] MONEY,
[ControlDate] DATETIME,
[LastUpdatedDate] DATETIME
)

AS
-------------------------------------------------------------------------------- 
-- Name: [Access.WebDev].[ufn_FinancialDashboardAll]
 
-- Params:	@FinancialYear INT - Financial Year for which the function is to be run for.
-------------------------------------------------------------------------------------- 
-- History:
-- R.Dixon: 08/03/2018 JIRA: OSPREY-1134 - Removed @OutputTable from SQL logic to improve performance
--Olu 27/04/2018 - Filter Out Data by Nominal Code and TransactionTypes
---------------------------------------------------------------------------------- 
-- Create Temp Table Variable
BEGIN
 DECLARE @TempAggregateData TABLE
 (
[FinancialFactId] BIGINT  NULL,
[FiscalYear] INT,
[FiscalFirstDayOfYear] DATE,
[FiscalLastDayOfYear] DATE,
[DepartmentNumber] SMALLINT  NULL,
[DepartmentName] SYSNAME  NULL,
[TransactionDate] VARCHAR(12)  NULL,
[Details] VARCHAR(4000),
[Amount] MONEY,
[Forecast] MONEY,
[TransactionNo] INT  NULL,
[AccountName] VARCHAR(128),
[AccountCategory] SYSNAME  NULL,
[TransactionTypeBK] CHAR(2)  NULL,
[Supplier] NVARCHAR(255)  NULL,
[NominalCode] INT  NULL,
[FinancialLineCode] VARCHAR(20)  NULL,
[ProjectName] VARCHAR(255)  NULL,
[IsDiscretionary] VARCHAR(2),
[IsNonDiscretionary] VARCHAR(2),
[AmountRaw] MONEY,
[ControlDate] DATETIME,
[LastUpdatedDate] DATETIME
);


 WITH DiscretionaryForcastsFix_CTE AS
	(
	SELECT d.FinancialFactId, 
	(CASE WHEN ISNULL(ABS(d.BudgetAmount),0) - ISNULL(ABS(n.BudgetAmount),0) < 0 THEN 0 ELSE ISNULL(ABS(d.BudgetAmount),0) - ISNULL(ABS(n.BudgetAmount),0) END) AS [Difference]
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
	  --AND d.BudgetAmount <> 0[TableauReporting][sys.workflowreporting]
	)
INSERT INTO @TempAggregateData
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
			MONTH(c.CalendarDate) IN (6,7,10,1) THEN 
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
		,(SELECT MAX(CONVERT(DATETIME, LEFT(ControlId, 8), 112)) FROM Fact.FinancialsFact) AS LastUpdatedDate
			
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
			AND f.DeletedRow = 0
			-- Filter out Data by TransactionTypes, NominalCodes and Detail Column
			AND(
			 ( tt.TransactionTypeBK IN ('PI')
			OR  tt.TransactionTypeBK IN ('PC')
			OR  tt.TransactionTypeBK IN ('JD', 'JC') AND  f.NominalCode = '9002' --  AND f.DetailNotes like '%Payroll%'
			OR  tt.TransactionTypeBK = 'BP'
			OR  tt.TransactionTypeBK = 'BR'
			OR  tt.TransactionTypeBK IN ('JD', 'JC')  AND  f.NominalCode IN ('4300', '4301', '4302', '4305', '4306', '4307')
			OR  tt.TransactionTypeBK  IN ('SI', 'SC')
			OR  flt.FinancialLineCode IN ('FD', 'FN', 'F', 'P')
			 OR f.DetailNotes like '%Payroll%'
			)
			AND c.FiscalYear = ISNULL( @FinancialYear,(SELECT FiscalYear FROM [Core].[Calendar] WHERE CalendarDate = CAST(GETDATE() AS DATE))))
			




---- Return All Aggregated Data from Temp table
INSERT INTO @AggregateData(
DepartmentName, TransactionDate, Amount, NominalCode,FinancialLineCode,IsDiscretionary,IsNonDiscretionary,FinancialFactId, FiscalYear,FiscalFirstDayOfYear,FiscalLastDayOfYear,DepartmentNumber,Details,Forecast,TransactionNo,AccountName,AccountCategory,TransactionTypeBK,
Supplier,ProjectName,AmountRaw,ControlDate,LastUpdatedDate)
SELECT
DepartmentName,
DATENAME(MONTH, TransactionDate) AS TransactionDate,
NULL AS Amount,
NominalCode,
FinancialLineCode,
IsDiscretionary,
IsNonDiscretionary,
NULL as	FinancialFactId,
NULL as      FiscalYear,
NULL as        FiscalFirstDayOfYear,
NULL as       FiscalLastDayOfYear,
NULL as      DepartmentNumber,   ---2836 roWS 
NULL AS Details,
ISNULL(SUM(Forecast),0) AS Forecast,
NULL AS TransactionNo,
NULL AS AccountName,
NULL AS AccountCategory,
NULL AS TransactionTypeBK,
NULL AS Supplier,
NULL AS ProjectName,
ISNULL(SUM(AmountRaw),0) AS AmountRaw,
NULL AS ControlDate,
NULL AS LastUpdatedDate 
FROM  @TempAggregateData
GROUP BY 
		TransactionDate,
		 NominalCode, 
		 FinancialLineCode,
		 DepartmentName,
		  IsDiscretionary,
       IsNonDiscretionary
	   
	   RETURN



END

