CREATE VIEW "CADIS"."DG_Investment_Dvd_NT_HighLevel_Override_Events_AUDIT" AS 
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
		,[KEY_DvdNTHighLevelOverrideEventId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT450"
