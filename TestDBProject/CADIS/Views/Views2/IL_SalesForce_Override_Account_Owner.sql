﻿CREATE VIEW "CADIS"."IL_SalesForce_Override_Account_Owner" AS 
SELECT V."sf_SfAccountId" AS "SF Account ID",V."DataField" AS "Exception Field",V."sf_FCAId",V."sf_OutletId", J4.DF AS "SalesForce Value", J5.DF AS "Matrix Value", J6.DF AS "Override Value",V."OverrideChoice" AS "Override Choice",V."OverrideStatus" AS "Override Status",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY" FROM "Sales.BP"."AccountOverride" V LEFT OUTER JOIN (SELECT DISTINCT "FullEmployeeBK" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J4 ON  J4.JF=V."sf_Value" LEFT OUTER JOIN (SELECT DISTINCT "FullEmployeeBK" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J5 ON  J5.JF=V."mx_Value" LEFT OUTER JOIN (SELECT DISTINCT "FullEmployeeBK" AS JF,"PersonsName" AS DF FROM "Core"."Persons")  J6 ON  J6.JF=V."OverrideValue"
