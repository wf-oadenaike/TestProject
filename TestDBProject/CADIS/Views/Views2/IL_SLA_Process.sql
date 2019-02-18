﻿CREATE VIEW "CADIS"."IL_SLA_Process" AS 
SELECT V."RUNID" AS "Run ID",V."RUNSTART" AS "Run Start",V."RUNEND" AS "Run End",V."RUNSUCCESSFUL" AS "Run Successful",V."LAUNCHEDBY" AS "Launched By",V."PARENTRUNID" AS "Parent Run ID",V."TOPLEVELRUNID" AS "Top Level Run ID",V."RETURNCODE" AS "Return Code",V."FAILEDRUNID" AS "Failed Run ID",V."PROCESSTYPE" AS "Process Type",V."PROCESSNAME" AS "Process Name",V."RUNTIME" AS "Run Time",V."LASTLOGENTRY" AS "Last Log Entry",V."TIMESINCELASTENTRY" AS "Time Since Last Entry",V."RUNCOMPLETE" AS "Run Complete" FROM "CADIS"."vwProcessHistory" V
