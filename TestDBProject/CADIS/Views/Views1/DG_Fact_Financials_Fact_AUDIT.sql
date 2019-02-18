CREATE VIEW "CADIS"."DG_Fact_Financials_Fact_AUDIT" AS 
	SELECT
		[ID]
		,[INSERTED]
		,[CHANGEDBY]
		,[FIELDNAME]
		,CASE
		 WHEN [ACTION] = 0 THEN 'Inserted'
		 WHEN [ACTION] = 1 THEN 'Updated'
		 ELSE 'Deleted' END AS [ACTION]
		,[OLDVALUE]
		,[NEWVALUE]
		,[VALIDATION]
		,[KEY_DepartmentId]
		,[KEY_PostingDateId]
		,[KEY_TransactionDateId]
		,[KEY_FinancialLineTypeId]
		,[KEY_NominalCode]
		,[KEY_TransactionNo]
		,[KEY_CurrentRow]
		,[KEY_CurrentRowSwitchId]
		,[KEY_DeletedRow]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT37"
