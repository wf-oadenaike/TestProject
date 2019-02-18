CREATE VIEW "CADIS"."DG_Organisation_Policy_Theme_Events_AUDIT" AS 
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
		,[KEY_PolicyThemeRegisterId]
		,[KEY_PolicyThemeEventTypeId]
		,[KEY_ReviewCollection]
		,[KEY_PersonId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT47"
