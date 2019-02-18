CREATE VIEW "CADIS"."DG_Sales_Client_Take_On_Distribution_Checks_AUDIT" AS 
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
		,[KEY_ClientTakeOnId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT154"
