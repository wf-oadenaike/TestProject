﻿CREATE VIEW "CADIS"."IL_Exception_Data_Load" AS 
SELECT V."SOURCE_TABLE" AS "Source Table",V."SOURCE_KEY" AS "Source Key",V."SOURCE_COLUMN" AS "Column",V."EXCEPTION_CODE" AS "Exception Code",V."EXCEPTION_DATE",V."EDM_ENTITY_ID",V."ENTITY" AS "Entity",V."EXCEPTION_NAME" AS "Exception Name",V."EXCEPTION_TYPE" AS "Exception Type", J9.DF AS "Status", J10.DF AS "Priority",V."COMMENT" AS "Comments", J12.DF AS "Owner", J13.DF AS "Team",V."SOURCE_VALUE" AS "Source Value",V."DATA_A_TYPE" AS "Type A",V."DATA_A_VALUE" AS "Value A",V."DATA_B_TYPE" AS "Type B",V."DATA_B_VALUE" AS "Value B",V."DATA_C_TYPE" AS "Type C",V."DATA_C_VALUE" AS "Value C",V."SOURCE" AS "Source",V."SOURCE_COMPONENT" AS "Component",V."RETENTION" AS "Retention",V."HASVALUECHANGED",V."DAYS_VALID" AS "Days Valid",V."OCCURRENCE" AS "Occurrence",V."EXCEPTION_AGE" AS "Exception Age",V."CUSIP" AS "CUSIP",V."ISIN" AS "ISIN",V."SECURITY_ID" AS "Security ID",V."SEDOL" AS "SEDOL",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED" AS "Last Updated",V."CADIS_SYSTEM_CHANGEDBY" AS "Changed By",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_LASTMODIFIED",V."CADIS_SYSTEM_TIMESTAMP" FROM "dbo"."T_EXCEPTION_LOAD" V LEFT OUTER JOIN (SELECT DISTINCT "Status" AS JF,"Status" AS DF FROM "dbo"."T_REF_EXCEPTION_STATUS")  J9 ON  J9.JF=V."STATUS" LEFT OUTER JOIN (SELECT DISTINCT "Priority" AS JF,"Priority" AS DF FROM "dbo"."T_REF_EXCEPTION_PRIORITY")  J10 ON  J10.JF=V."PRIORITY" LEFT OUTER JOIN (SELECT DISTINCT "OWNER" AS JF,"OWNER" AS DF FROM "dbo"."T_REF_EXCEPTION_OWNER")  J12 ON  J12.JF=V."OWNER" LEFT OUTER JOIN (SELECT DISTINCT "Team" AS JF,"Team" AS DF FROM "dbo"."T_REF_EXCEPTION_TEAM")  J13 ON  J13.JF=V."TEAM"