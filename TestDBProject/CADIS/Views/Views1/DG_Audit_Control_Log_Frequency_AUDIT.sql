﻿CREATE VIEW "CADIS"."DG_Audit_Control_Log_Frequency_AUDIT" AS 
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
		,[KEY_ControlLogFrequencyId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT94"
