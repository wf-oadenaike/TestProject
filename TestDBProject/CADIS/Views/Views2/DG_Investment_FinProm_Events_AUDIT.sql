CREATE VIEW "CADIS"."DG_Investment_FinProm_Events_AUDIT" AS 
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
		,[KEY_FinPromEventType]
		,[KEY_EventDate]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT15"
