﻿CREATE VIEW "CADIS"."DG_Compliance_Watchlist_Events_AUDIT" AS 
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
		,[KEY_WatchlistEventId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT637"
