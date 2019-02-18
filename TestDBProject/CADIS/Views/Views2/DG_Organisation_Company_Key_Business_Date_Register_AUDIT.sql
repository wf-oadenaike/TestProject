CREATE VIEW "CADIS"."DG_Organisation_Company_Key_Business_Date_Register_AUDIT" AS 
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
		,[KEY_CompanyKeyBusinessDateId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT227"
