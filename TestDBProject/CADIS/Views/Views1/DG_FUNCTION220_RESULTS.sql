CREATE VIEW "CADIS"."DG_FUNCTION220_RESULTS" AS 
SELECT ET."KPIIDBK",ET."KPIMetaDataId",ET."IsPercentage",ET."Frequency",ET."KPIName",ET."KPIDescription",ET."TargetValue",ET."ValueDirection",ET."AggrFunction",ET."SortOrder",ET."IsActive",ET."IsCalculated",ET."CreatedAt",ET."UpdatedAt" FROM "Staging.KPI"."KPIMetaData" ET WITH (NOLOCK)
