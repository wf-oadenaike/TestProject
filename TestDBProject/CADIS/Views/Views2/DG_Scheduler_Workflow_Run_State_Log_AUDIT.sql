CREATE VIEW "CADIS"."DG_Scheduler_Workflow_Run_State_Log_AUDIT" AS 
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
		,[KEY_WorkflowRunStateLogId]
	FROM "CADIS_PROC"."DG_FUNCTION_AUDIT20"
