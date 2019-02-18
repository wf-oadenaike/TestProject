CREATE VIEW "CADIS"."DG_FUNCTION480_RESULTS" AS 
SELECT ET."sf_SfAccountId",ET."DataField",ET."sf_FCAId",ET."sf_OutletId",ET."sf_Value",ET."mx_Value",ET."OverrideValue",ET."OverrideChoice",ET."OverrideStatus",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Sales.BP"."AccountOverride" ET WITH (NOLOCK)
