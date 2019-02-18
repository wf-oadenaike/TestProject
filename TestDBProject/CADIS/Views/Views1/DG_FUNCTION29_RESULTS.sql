﻿CREATE VIEW "CADIS"."DG_FUNCTION29_RESULTS" AS 
SELECT ET."RiskRegisterEventId",ET."RiskRegisterId",ET."RiskEventTypeID",ET."RiskRegisterEventPersonId",ET."RiskRegisterEventComment",ET."RiskRegisterEventCreationDate",ET."WorkflowVersionGUID",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "Risk"."RiskRegisterEvents" ET WITH (NOLOCK)