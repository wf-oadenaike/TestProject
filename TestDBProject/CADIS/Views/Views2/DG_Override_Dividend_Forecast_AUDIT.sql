CREATE VIEW "CADIS"."DG_Override_Dividend_Forecast_AUDIT" AS 
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
		,[KEY_FundShortName]
		,[KEY_EDM_SEC_ID]
		,[KEY_CalendarYear]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT750"
