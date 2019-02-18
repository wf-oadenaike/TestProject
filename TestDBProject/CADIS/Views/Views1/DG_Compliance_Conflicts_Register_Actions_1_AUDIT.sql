CREATE VIEW "CADIS"."DG_Compliance_Conflicts_Register_Actions_1_AUDIT" AS 
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
		,[KEY_ConflictsRegisterActionId_1]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT732"
