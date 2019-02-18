CREATE VIEW "CADIS"."DG_FUNCTION63_RESULTS" AS 
SELECT ET."MonitoringThemeId",ET."MonitoringCategoryId",ET."ThemeName",ET."ThemeSummary",ET."SubmittedByPersonId",ET."JoinGUID",ET."MonitoringThemeCreationDate",ET."MonitoringThemeLastModifiedDate" FROM "Access.ManyWho"."ComplianceMonitoringThemesVw" ET WITH (NOLOCK)
