﻿CREATE VIEW "CADIS"."IL_SalesForce_Override_Contact" AS 
SELECT V."sf_SfContactId" AS "SF Contact ID",V."DataField" AS "Exception Field",V."sf_SfAccountId" AS "SF Account ID",V."sf_FcaId",V."sf_ContractMatrixId",V."sf_AccountFcaId",V."sf_LastName" AS "SF Last Name",V."sf_FirstName" AS "SF First Name",V."sf_Value" AS "SalesForce Value",V."mx_Value" AS "Matrix Value",V."Mover" AS "Mover",V."OverrideValue" AS "Override Value",V."OverrideChoice" AS "Override Choice",V."OverrideStatus" AS "Override Status" FROM "Sales.BP"."ContactOverride" V
