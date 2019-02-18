
CREATE PROCEDURE [Finance].[usp_CreateProjections]

AS
-------------------------------------------------------------------------------------- 
-- Name: [Finance].[usp_CreateProjections]
-- 
-- Params:	
-------------------------------------------------------------------------------------- 
-- History:
-- R. Dixon: 13/04/2018 DAP-1829	Updated to calculate project year end figures as 
--									actual YTD figures + (average monthly figure for 
--									the last 3 months * number of months left)
-------------------------------------------------------------------------------------- 

DECLARE	@Table TABLE
		(
		TransactionDate BIGINT NOT NULL,
		ExpenseProjection DECIMAL(18,6) NOT NULL,
		RevenueProjection DECIMAL (18,6) NOT NULL
		)
DECLARE @ReportDate DATETIME,
		@M INT

-- Set report date to latest actual transaction date in finance data.
SELECT	@ReportDate = MAX(TransactionDate) 
FROM	[Reporting].[FinanceDashboardAllVw]
WHERE	FinancialLineCode = 'A'

-- Get total revenue and expenses for each month of financial calendar year
SELECT	[TransactionDate], Data1.X, YExpense, YRevenue
INTO	#Data
FROM	(
		SELECT 
				MIN(TransactionDate) AS [TransactionDate]
				,MONTH(DATEADD(mm,-3,TransactionDate)) AS X
				, SUM(AmountRaw)AS YExpense
		FROM	[Reporting].[FinanceDashboardAllVw]
		WHERE	@ReportDate  BETWEEN FiscalFirstDayOfYear AND FiscalLastDayOfYear AND NominalCode >= 4300 AND FinancialLineCode = 'A' AND NominalCode <> 9001
		GROUP	BY MONTH(DATEADD(mm,-3,TransactionDate))
		) data1
LEFT	JOIN 
		(
		SELECT	MONTH(DATEADD(mm,-3,TransactionDate)) AS X
				, SUM(Amount) * -1 AS YRevenue
		FROM	[Reporting].[FinanceDashboardAllVw]
		WHERE	@ReportDate  BETWEEN FiscalFirstDayOfYear AND FiscalLastDayOfYear AND NominalCode BETWEEN 4000 AND 4299 AND FinancialLineCode = 'A'
		GROUP	BY MONTH(DATEADD(mm,-3,TransactionDate))
		) AS data2 ON data1.X = data2.X
 WHERE	YExpense IS NOT NULL

-- Get total revenue and expenses for each month of previous financial calendar year 
INSERT	INTO	#Data
SELECT	[TransactionDate], Data1.X, YExpense, YRevenue
FROM	(
		SELECT 
				MIN(TransactionDate) AS [TransactionDate]
				,MONTH(DATEADD(mm,-3,TransactionDate)) - 12 AS X
				, SUM(AmountRaw)AS YExpense
		FROM	[Reporting].[FinanceDashboardAllVw]
		WHERE	DATEADD(yy,-1,@ReportDate)  BETWEEN FiscalFirstDayOfYear AND FiscalLastDayOfYear AND NominalCode >= 4300 AND FinancialLineCode = 'A' AND NominalCode <> 9001
		GROUP	BY MONTH(DATEADD(mm,-3,TransactionDate))
		) data1
LEFT	JOIN 
		(
		SELECT	MONTH(DATEADD(mm,-3,TransactionDate)) - 12 AS X
				, SUM(Amount) * -1 AS YRevenue
		FROM	[Reporting].[FinanceDashboardAllVw]
		WHERE	DATEADD(yy,-1,@ReportDate)   BETWEEN FiscalFirstDayOfYear AND FiscalLastDayOfYear AND NominalCode BETWEEN 4000 AND 4299 AND FinancialLineCode = 'A'
		GROUP	BY MONTH(DATEADD(mm,-3,TransactionDate))
		) AS data2 ON data1.X = data2.X
 WHERE	YExpense IS NOT NULL
 
 -- Loop through months of current financial year
DECLARE	MONTH_CURSOR CURSOR FOR
SELECT	X
FROM	#Data d
WHERE	X > 0
ORDER	BY X ASC

OPEN	MONTH_CURSOR

FETCH	NEXT FROM MONTH_CURSOR
INTO	@M

WHILE @@FETCH_STATUS = 0
	BEGIN

-- insert revenue and expense projected year end figures. These are calculated as:
-- Actual YTD figures + (average monthly figure for the last 3 months * number of months left)
	INSERT	INTO @Table
	SELECT	CONVERT(BIGINT,CONVERT(VARCHAR(4),YEAR(dsum.TransactionDate))+  RIGHT('0' + CONVERT(VARCHAR(2),MONTH(dsum.TransactionDate)),2) + RIGHT('0' + CONVERT(VARCHAR(2),DAY(dsum.TransactionDate)),2)),
			dsum.Expense_YTD + (12 - @M) * davg.Expense_3MAVG AS ExpenseProjection,
			dsum.Revenue_YTD + (12 - @M) * davg.Revenue_3MAVG AS RevenueProjection
	FROM	(
			SELECT	@M AS X, SUM(YExpense) AS Expense_YTD, SUM(YRevenue) AS Revenue_YTD, MAX(TransactionDate) AS TransactionDate
			FROM	#Data 
			WHERE	X BETWEEN 1 AND @M
			) dsum
	INNER	JOIN
			(
			SELECT	@M AS X, AVG(YExpense) AS Expense_3MAVG, AVG(YRevenue) AS Revenue_3MAVG
			FROM	#Data
			WHERE	X BETWEEN @M-2 and @M
			) davg
	ON		dsum.X = davg.X
	
	FETCH NEXT FROM MONTH_CURSOR
	INTO @M
END

CLOSE MONTH_CURSOR
DEALLOCATE MONTH_CURSOR

DROP TABLE #DATA

CREATE TABLE #TmpTable( [DepartmentId] [smallint] NOT NULL,
	[PostingDateId] [int] NOT NULL,
	[TransactionDateId] [int] NOT NULL,
	[BudgetAmount] [money] NULL,
	[ActualAmount] [money] NULL,
	[ControlId] [bigint] NOT NULL,
	[SourceSystemId] [smallint] NOT NULL,
	[FinancialLineTypeId] [smallint] NOT NULL,
	[AccountRef] [varchar](20) NULL,
	[NominalCode] [int] NOT NULL,
	[TransactionNo] [int] NOT NULL,
	[TaxCode] [char](3) NULL,
	[DetailNotes] [varchar](255) NULL,
	[TransactionTypeId] [smallint] NOT NULL ,
	[CountOf] [int] NOT NULL,
	[CurrentRow] [bit] NOT NULL,
	[CurrentRowSwitchId] [bigint] NOT NULL,
	[DeletedRow] [bit] NOT NULL)

INSERT INTO #TmpTable
           ([DepartmentId]
           ,[PostingDateId]
           ,[TransactionDateId]
           ,[BudgetAmount]
           ,[ActualAmount]
           ,[ControlId]
           ,[SourceSystemId]
           ,[FinancialLineTypeId]
           ,[AccountRef]
           ,[NominalCode]
           ,[TransactionNo]
           ,[TaxCode]
           ,[DetailNotes]
           ,[TransactionTypeId]
           ,[CountOf]
           ,[CurrentRow]
           ,[CurrentRowSwitchId]
           ,[DeletedRow])
  SELECT
           1
           ,TransactionDate
           ,TransactionDate
           ,RevenueProjection
           ,ExpenseProjection
           ,CONVERT( BIGINT, REPLACE( REPLACE( REPLACE( CONVERT( varchar, GETDATE(), 120), '-', ''), ' ', ''), ':', ''))
           ,1
           ,9
           ,NULL
           ,4000
           ,-1
           ,NULL
           ,'Projected revenue/expenses'
           ,-1
           ,1
           ,1
           ,-1
           ,0
FROM	@Table

MERGE INTO Fact.FinancialsFact Tar
					USING ( SELECT 
								[DepartmentId]
							   ,[PostingDateId]
							   ,[TransactionDateId]
							   ,[BudgetAmount]
							   ,[ActualAmount]
							   ,[ControlId]
							   ,[SourceSystemId]
							   ,[FinancialLineTypeId]
							   ,[AccountRef]
							   ,[NominalCode]
							   ,[TransactionNo]
							   ,[TaxCode]
							   ,[DetailNotes]
							   ,[TransactionTypeId]
							   ,[CountOf]
							   ,[CurrentRow]
							   ,[CurrentRowSwitchId]
							   ,[DeletedRow]
							FROM #TmpTable
						) as Src
					ON (
						tar.[NominalCode] = src.[NominalCode]
						AND Tar.[TransactionNo] = Src.[TransactionNo]
						AND Tar.[TransactionDateId] = Src.[TransactionDateId]
						AND Tar.[FinancialLineTypeId] = Src.[FinancialLineTypeId]
						AND Tar.[CurrentRow] = 1
						AND Tar.[DeletedRow] = 0)
					WHEN NOT MATCHED BY TARGET
						THEN INSERT ([DepartmentId]
							   ,[PostingDateId]
							   ,[TransactionDateId]
							   ,[BudgetAmount]
							   ,[ActualAmount]
							   ,[ControlId]
							   ,[SourceSystemId]
							   ,[FinancialLineTypeId]
							   ,[AccountRef]
							   ,[NominalCode]
							   ,[TransactionNo]
							   ,[TaxCode]
							   ,[DetailNotes]
							   ,[TransactionTypeId]
							   ,[CountOf]
							   ,[CurrentRow]
							   ,[CurrentRowSwitchId]
							   ,[DeletedRow]
							   ,JournalLineID)
								VALUES (Src.[DepartmentId]
							   ,Src.[PostingDateId]
							   ,Src.[TransactionDateId]
							   ,Src.[BudgetAmount]
							   ,Src.[ActualAmount]
							   ,Src.[ControlId]
							   ,Src.[SourceSystemId]
							   ,Src.[FinancialLineTypeId]
							   ,Src.[AccountRef]
							   ,Src.[NominalCode]
							   ,Src.[TransactionNo]
							   ,Src.[TaxCode]
							   ,Src.[DetailNotes]
							   ,Src.[TransactionTypeId]
							   ,Src.[CountOf]
							   ,Src.[CurrentRow]
							   ,Src.[CurrentRowSwitchId]
							   ,Src.[DeletedRow]
							   ,Src.[PostingDateId])
					WHEN MATCHED AND (ISNULL(Tar.[ActualAmount], -999999) <> ISNULL(Src.[ActualAmount], -999999)
										OR ISNULL(Tar.[BudgetAmount], -999999) <> ISNULL(Src.[BudgetAmount], -999999)
									)
						THEN UPDATE SET [BudgetAmount] = Src.[BudgetAmount]
									, [ActualAmount] = Src.[ActualAmount],
									[ControlId] = Src.[ControlId];
				
DROP TABLE #TmpTable
RETURN 0

