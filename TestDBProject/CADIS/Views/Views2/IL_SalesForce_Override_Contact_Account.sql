﻿CREATE VIEW "CADIS"."IL_SalesForce_Override_Contact_Account" AS 
SELECT V."sf_SfContactId" AS "SF Contact ID",V."DataField" AS "Exception Field",V."sf_SfAccountId" AS "SF Account ID",V."sf_FcaId",V."sf_ContractMatrixId",V."sf_AccountFcaId",V."sf_LastName" AS "SF Last Name",V."sf_FirstName" AS "SF First Name", J8.DF AS "SalesForce Value", J9.DF AS "Matrix Value",V."Mover" AS "Mover",V."OverrideValue" AS "Override Value",V."OverrideChoice" AS "Override Choice",V."OverrideStatus" AS "Override Status" FROM "Sales.BP"."ContactOverride" V LEFT OUTER JOIN (SELECT DISTINCT "AccountSivId" AS JF,"AccountName" AS DF FROM "dbo"."SfAccountVw")  J8 ON  J8.JF=V."sf_Value" LEFT OUTER JOIN (SELECT DISTINCT "AccountSivId" AS JF,"AccountName" AS DF FROM "dbo"."MxAccountVw")  J9 ON  J9.JF=V."mx_Value"