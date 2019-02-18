﻿CREATE VIEW "CADIS"."DG_Override_Security_Quarterly_Income_AUDIT" AS 
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
		,[KEY_FUND_SHORT_NAME]
		,[KEY_EDM_SEC_ID]
		,[KEY_FUND_FISCAL_YEAR]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT754"
