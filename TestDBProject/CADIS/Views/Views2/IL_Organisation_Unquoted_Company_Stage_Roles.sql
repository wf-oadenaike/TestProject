﻿CREATE VIEW "CADIS"."IL_Organisation_Unquoted_Company_Stage_Roles" AS 
SELECT  J0.DF AS "Unquoted Company Stage", J1.DF AS "Role ID",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Organisation"."UnquotedCompanyStageRoles" V LEFT OUTER JOIN (SELECT DISTINCT "UnquotedCompanyStage" AS JF,"UnquotedCompanyStageDescription" AS DF FROM "Organisation"."UnquotedCompanyStages")  J0 ON  J0.JF=V."UnquotedCompanyStage" LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J1 ON  J1.JF=V."RoleId"
