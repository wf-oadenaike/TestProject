﻿CREATE VIEW "CADIS"."DG_Change_Management_Change_Approvers_AUDIT" AS 
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
		,[KEY_ApproverID]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT274"
