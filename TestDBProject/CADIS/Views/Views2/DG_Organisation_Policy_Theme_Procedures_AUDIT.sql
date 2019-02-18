CREATE VIEW "CADIS"."DG_Organisation_Policy_Theme_Procedures_AUDIT" AS 
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
		,[KEY_PTPCategoryId]
		,[KEY_PolicyThemeProcedureNameBK]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT45"
