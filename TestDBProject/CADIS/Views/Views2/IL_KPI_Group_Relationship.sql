﻿CREATE VIEW "CADIS"."IL_KPI_Group_Relationship" AS 
SELECT V."KPIId" AS "KPI ID", J1.DF AS "KPI Group ID",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "KPI"."KPIGroupRelationship" V LEFT OUTER JOIN (SELECT DISTINCT "KPIGroupId" AS JF,"KPIGroupName" AS DF FROM "KPI"."KPIGroups")  J1 ON  J1.JF=V."KPIGroupId"
