CREATE VIEW "CADIS"."DG_FUNCTION45_RESULTS" AS 
SELECT ET."PolicyThemeRegisterId",ET."PTPCategoryId",ET."PolicyThemeProcedureNameBK",ET."PolicyThemeProcedureId",ET."ActiveFlag",ET."ActiveFromDatetime",ET."ActiveToDatetime" FROM "Organisation"."PolicyThemeProcedures" ET WITH (NOLOCK)
