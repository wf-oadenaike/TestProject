﻿CREATE VIEW "CADIS"."IL_Audit_Control_Log_Register" AS 
SELECT V."ControlLogRegisterId" AS "Control Log Register ID",V."ControlDescription" AS "Control Description", J2.DF AS "Control Log Category ID", J3.DF AS "Control Log Frequency ID",V."AdhocFrequencyYesNo" AS "Adhoc Frequency Yes or No",V."EvidenceDescription" AS "Evidence Description", J6.DF AS "Owner Role ID", J7.DF AS "Owner Third Party ID",V."OriginalControlOwner" AS "Original Control Owner",V."JoinGUID" AS "Join GUID",V."ControlLogRegisterCreationDatetime" AS "Control Log Register Creation Date",V."ControlLogRegisterLastModifiedDatetime" AS "Control Log Register Last Modified",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Audit"."ControlLogRegister" V LEFT OUTER JOIN (SELECT DISTINCT "ControlLogCategoryId" AS JF,"CategoryName" AS DF FROM "Audit"."ControlLogCategories")  J2 ON  J2.JF=V."ControlLogCategoryId" LEFT OUTER JOIN (SELECT DISTINCT "ControlLogFrequencyId" AS JF,"FrequencyName" AS DF FROM "Audit"."ControlLogFrequency")  J3 ON  J3.JF=V."ControlLogFrequencyId" LEFT OUTER JOIN (SELECT DISTINCT "RoleId" AS JF,"RoleName" AS DF FROM "Core"."Roles")  J6 ON  J6.JF=V."OwnerRoleId" LEFT OUTER JOIN (SELECT DISTINCT "ThirdPartyId" AS JF,"ThirdPartyName" AS DF FROM "Core"."ThirdParties")  J7 ON  J7.JF=V."OwnerThirdPartyId"