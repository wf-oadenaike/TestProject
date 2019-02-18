CREATE VIEW "CADIS"."DG_PolicyProc_Policy_To_Policy_Relationship_AUDIT" AS 
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
		,[KEY_PolicyId1]
		,[KEY_PolicyId2]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT249"
