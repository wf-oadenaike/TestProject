﻿CREATE VIEW "CADIS"."DG_Override_FX_Rate_AUDIT" AS 
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
		,[KEY_FXRATE_ID]
		,[KEY_DATE]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT41"
