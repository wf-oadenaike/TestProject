﻿CREATE VIEW "CADIS"."DG_FUNCTION534_RESULTS" AS 
SELECT ET."FUNDING_ID",ET."ISSUER",ET."EDM_SEC_ID",ET."TRADE_DATE",ET."SETTLEMENT_DATE",ET."FUNDING_STATUS",ET."IS_LEGAL",ET."IS_REPUTATIONAL",ET."FUNDING_TYPE",ET."FUNDING_SUB_TYPE",ET."PUSH_BACK_UNIT",ET."PUSH_BACK_MAGNITUDE",ET."PULL_FORWARD_UNIT",ET."PULL_FORWARD_MAGNITUDE",ET."TECH_STATUS",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."JiraIssueKey",ET."IssuerID" FROM "dbo"."T_UNQUOTED_FUNDING" ET WITH (NOLOCK)
