CREATE VIEW "CADIS"."DG_Core_Employee_Info_History_AUDIT" AS 
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
		,[KEY_PersonId]
		,[KEY_EffectiveDate]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT314"
