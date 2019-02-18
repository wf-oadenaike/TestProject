CREATE VIEW "CADIS"."IL_Monitor_Process_Log" AS 
SELECT V."RUNID" AS "Run ID",V."LOGTIME" AS "Log Time",V."LOGMESSAGE" AS "Log Message",V."PROCESSTYPE" AS "Process Type",V."PROCESSNAME" AS "Process Name" FROM "CADIS"."vwProcessLog" V
