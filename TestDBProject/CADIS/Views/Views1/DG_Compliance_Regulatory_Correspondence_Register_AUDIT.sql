﻿CREATE VIEW "CADIS"."DG_Compliance_Regulatory_Correspondence_Register_AUDIT" AS 
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
		,[KEY_RegulatoryCorrespondenceId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT146"
