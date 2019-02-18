CREATE VIEW [Access.ManyWho].[ComplianceMonitoringThemesVw]
	AS 
SELECT
	  MonitoringThemeId
	, MonitoringCategoryId
	, ThemeName
	, ThemeSummary
	, SubmittedByPersonId
	, JoinGUID
	, MonitoringThemeCreationDate
	, MonitoringThemeLastModifiedDate
  FROM [Compliance].[MonitoringThemes]
;
