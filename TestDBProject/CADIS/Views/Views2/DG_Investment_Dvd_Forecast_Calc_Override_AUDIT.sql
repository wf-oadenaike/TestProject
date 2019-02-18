CREATE VIEW "CADIS"."DG_Investment_Dvd_Forecast_Calc_Override_AUDIT" AS 
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
		,[KEY_DvdForecastCalcOverrideId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT409"
