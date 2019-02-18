﻿CREATE VIEW "CADIS"."DG_FUNCTION463_RESULTS" AS 
SELECT ET."EXCEPTION_DATE",ET."SOURCE_TABLE",ET."SOURCE_KEY",ET."SOURCE_COLUMN",ET."EXCEPTION_CODE",ET."EDM_ENTITY_ID",ET."ENTITY",ET."EXCEPTION_NAME",ET."EXCEPTION_TYPE",ET."SOURCE_VALUE",ET."SOURCE",ET."SOURCE_COMPONENT",ET."STATUS",ET."PRIORITY",ET."COMMENT",ET."OWNER",ET."TEAM",ET."DATA_A_TYPE",ET."DATA_A_VALUE",ET."DATA_B_TYPE",ET."DATA_B_VALUE",ET."DATA_C_TYPE",ET."DATA_C_VALUE",ET."RETENTION",ET."HASVALUECHANGED",ET."DAYS_VALID",ET."OCCURRENCE",ET."EXCEPTION_AGE",ET."CUSIP",ET."ISIN",ET."SECURITY_ID",ET."SEDOL",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."CADIS_SYSTEM_PRIORITY",ET."CADIS_SYSTEM_LASTMODIFIED",ET."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_EXCEPTION_LOAD" ET WITH (NOLOCK)