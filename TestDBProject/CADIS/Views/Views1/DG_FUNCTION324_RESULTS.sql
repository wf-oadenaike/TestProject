﻿CREATE VIEW "CADIS"."DG_FUNCTION324_RESULTS" AS 
SELECT ET."InvestmentOpsEventId",ET."InvestmentOpsDailyTasksRegisterId",ET."InvestmentOpsEventDate",ET."InvestmentOpsEventStatus",ET."JIRAIssueKey",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Operation"."InvestmentOpsEvents" ET WITH (NOLOCK)
