﻿CREATE VIEW "CADIS"."DG_Override_Price_Expiry_AUDIT" AS 
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
		,[KEY_EDM_SEC_ID]
		,[KEY_PRICE_TYPE]
		,[KEY_PRICE_DATE]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT192"