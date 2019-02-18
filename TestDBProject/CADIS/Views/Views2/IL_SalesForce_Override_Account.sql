CREATE VIEW "CADIS"."IL_SalesForce_Override_Account" AS 
SELECT V."sf_SfAccountId" AS "SF Account ID",V."DataField" AS "Exception Field",V."sf_FCAId",V."sf_OutletId",V."sf_Value" AS "SalesForce Value",V."mx_Value" AS "Matrix Value",V."OverrideValue" AS "Override Value",V."OverrideChoice" AS "Override Choice",V."OverrideStatus" AS "Override Status" FROM "Sales.BP"."AccountOverride" V
