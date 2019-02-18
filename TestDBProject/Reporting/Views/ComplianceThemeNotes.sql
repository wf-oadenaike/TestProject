CREATE VIEW [Reporting].[ComplianceThemeNotes]
	AS
  WITH CTE_Collections AS (
	SELECT DISTINCT [MonitoringThemeNoteCollectionSeqId], rpd_uf.PeriodStartDate, n.SubmittedByPersonId, n.[MonitoringThemeId]
	  , rpd_uf.PeriodEndDate	  FROM 
	[Compliance].[MonitoringThemeNotes] n
	INNER JOIN [Compliance].[MonitoringThemes] t ON n.MonitoringThemeId = t.MonitoringThemeId
	CROSS APPLY [Compliance].[GetMonitoringReportingPeriodDates_uf] ([MonitoringCategoryId], [MonitoringThemeNotesCreationDatetime]) AS rpd_uf
)
SELECT 
	collections.PeriodStartDate
	,collections.PeriodEndDate
	,themes.[MonitoringCategoryId]
	,collections.[MonitoringThemeId]
	,themes.ThemeName
	,p.PersonsName
	,mcn_e.[ThemeNote] AS EventDetails
	,mcn_flr.[ThemeNote] AS FirstLineResponse
	,mcn_cc.[ThemeNote] AS ComplianceConcerns
	,mcn_g.[ThemeNote] AS Governance
	,coalesce(mcn_e.occurrencedate,mcn_flr.occurrencedate,mcn_cc.occurrencedate,mcn_g.occurrencedate) as OccurrenceDate
	,COALESCE(mcn_e.[MonitoringThemeNotesCreationDatetime], mcn_flr.[MonitoringThemeNotesCreationDatetime], mcn_cc.[MonitoringThemeNotesCreationDatetime], mcn_g.[MonitoringThemeNotesCreationDatetime]) AS NoteCreationDate
  FROM CTE_Collections collections
  LEFT JOIN [Compliance].[MonitoringThemeNotes] mcn_e ON mcn_e.[MonitoringThemeNoteCollectionSeqId] = collections.[MonitoringThemeNoteCollectionSeqId] AND mcn_e.[MonitoringNoteTypeId] = 1
  LEFT JOIN [Compliance].[MonitoringThemeNotes] mcn_flr ON mcn_flr.[MonitoringThemeNoteCollectionSeqId] = collections.[MonitoringThemeNoteCollectionSeqId] AND mcn_flr.[MonitoringNoteTypeId] = 2
  LEFT JOIN [Compliance].[MonitoringThemeNotes] mcn_cc ON mcn_cc.[MonitoringThemeNoteCollectionSeqId] = collections.[MonitoringThemeNoteCollectionSeqId] AND mcn_cc.[MonitoringNoteTypeId] = 3
  LEFT JOIN [Compliance].[MonitoringThemeNotes] mcn_g ON mcn_g.[MonitoringThemeNoteCollectionSeqId] = collections.[MonitoringThemeNoteCollectionSeqId] AND mcn_g.[MonitoringNoteTypeId] = 4
  INNER JOIN [Core].[Persons] p ON p.PersonId = collections.SubmittedByPersonId
  INNER JOIN [Compliance].[MonitoringThemes] themes ON themes.[MonitoringThemeId] = collections.[MonitoringThemeId]
