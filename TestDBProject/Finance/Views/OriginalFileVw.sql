CREATE VIEW [Finance].[OriginalFileVw]
AS
SELECT 
	[TransactionNo]
	,[TransactionTypeBK]
	,c.FullDateUK
	,[AccountRef]
	,ff.NominalCode
	,[DetailNotes]
	,d.[DepartmentNumber]
	,d.DepartmentName
	,[TaxCode]
	,[ActualAmount]
	,[PnLBS]
	,ac.AccountCategory AS [Account Category]
	,anc.AccountName AS F20
	,[FinancialFactId]
	,ff.[TransactionTypeId]
	,[PostingDateId]
	,[TransactionDateId]
	,ff.[ControlId]
	,ff.[SourceSystemId]
	,ff.[DepartmentId]
	,[FinancialLineTypeId] 
	,[BudgetAmount]
	,anc.[AccountCategoryId]
	,[CountOf]
	,[CurrentRow]
	,[CurrentRowSwitchId]
	,[DeletedRow]
FROM 
	[Fact].[FinancialsFact] ff
LEFT JOIN 
	[Finance].[TransactionTypes] tt ON ff.TransactionTypeId = tt.TransactionTypeId
INNER JOIN 
	[Core].[Calendar] c ON ff.TransactionDateId = c.CalendarId
LEFT JOIN 
	[Finance].[AccountNominalCodes] anc ON anc.NominalCode = ff.NominalCode
LEFT JOIN 
	[Finance].[AccountCategories] ac ON ac.AccountCategoryId = anc.AccountCategoryId
LEFT JOIN 
	[Core].[Departments] d ON d.DepartmentId = ff.DepartmentId
WHERE DeletedRow = 0 --AND FullDateUK >= '01/04/2015'
AND CurrentRow = 1
AND [TransactionNo] <> -1
