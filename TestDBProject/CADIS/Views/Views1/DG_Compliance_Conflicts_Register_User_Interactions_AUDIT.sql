﻿CREATE VIEW "CADIS"."DG_Compliance_Conflicts_Register_User_Interactions_AUDIT" AS 
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
		,[KEY_ConflictsRegisterUserInteractionId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT26"
