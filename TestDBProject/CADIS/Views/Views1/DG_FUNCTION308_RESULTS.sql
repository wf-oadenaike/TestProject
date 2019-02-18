CREATE VIEW "CADIS"."DG_FUNCTION308_RESULTS" AS 
SELECT ET."AssetTypeId",ET."AssetType",ET."AssetCode",ET."DepreciationType",ET."WritedownPeriod" FROM "Organisation"."AssetTypes" ET WITH (NOLOCK)
