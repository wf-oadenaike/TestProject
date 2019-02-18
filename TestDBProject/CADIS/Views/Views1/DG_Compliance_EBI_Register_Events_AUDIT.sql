CREATE VIEW "CADIS"."DG_Compliance_EBI_Register_Events_AUDIT" AS 
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
		,[KEY_EBIRegisterId]
		,[KEY_EBIEventTypeId]
		,[KEY_EBIEventCreationDatetime]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT11"
