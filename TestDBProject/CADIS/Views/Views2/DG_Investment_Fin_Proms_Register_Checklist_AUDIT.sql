CREATE VIEW "CADIS"."DG_Investment_Fin_Proms_Register_Checklist_AUDIT" AS 
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
		,[KEY_FinPromRegisterId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT243"
