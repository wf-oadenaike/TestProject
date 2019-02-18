CREATE VIEW "CADIS"."DG_Investment_Research_Broker_Budget_Changes_AUDIT" AS 
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
		,[KEY_BudgetChangeId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT98"
