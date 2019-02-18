CREATE VIEW [Reporting].[ComplianceCategoryNotes]
	AS
WITH CTE_Collections AS (
	SELECT DISTINCT [MonitoringNoteCollectionSeqId], rpd_uf.PeriodStartDate, SubmittedByPersonId, MonitoringCategoryId
	  , rpd_uf.PeriodEndDate	  FROM 
	[Compliance].[MonitoringCategoryNotes]
	CROSS APPLY [Compliance].[GetMonitoringReportingPeriodDates_uf] (MonitoringCategoryId, CategoryNoteCreationDate) AS rpd_uf
)
SELECT 
	collections.PeriodStartDate
	,collections.PeriodEndDate
	,collections.MonitoringCategoryId
	,cat.CategoryName
	,p.PersonsName
	,mcn_e.CategoryNote AS EventDetails
	,mcn_flr.CategoryNote AS FirstLineResponse
	,mcn_cc.CategoryNote AS ComplianceConcerns
	,mcn_g.CategoryNote AS Governance
	,coalesce(mcn_e.occurrencedate,mcn_flr.occurrencedate,mcn_cc.occurrencedate,mcn_g.occurrencedate) as OccurrenceDate
	,COALESCE(mcn_e.CategoryNoteCreationDate, mcn_flr.CategoryNoteCreationDate, mcn_cc.CategoryNoteCreationDate, mcn_g.CategoryNoteCreationDate) AS NoteCreationDate
  FROM CTE_Collections collections
  LEFT JOIN [Compliance].[MonitoringCategoryNotes] mcn_e ON mcn_e.[MonitoringNoteCollectionSeqId] = collections.[MonitoringNoteCollectionSeqId] AND mcn_e.[MonitoringNoteTypeId] = 1
  LEFT JOIN [Compliance].[MonitoringCategoryNotes] mcn_flr ON mcn_flr.[MonitoringNoteCollectionSeqId] = collections.[MonitoringNoteCollectionSeqId] AND mcn_flr.[MonitoringNoteTypeId] = 2
  LEFT JOIN [Compliance].[MonitoringCategoryNotes] mcn_cc ON mcn_cc.[MonitoringNoteCollectionSeqId] = collections.[MonitoringNoteCollectionSeqId] AND mcn_cc.[MonitoringNoteTypeId] = 3
  LEFT JOIN [Compliance].[MonitoringCategoryNotes] mcn_g ON mcn_g.[MonitoringNoteCollectionSeqId] = collections.[MonitoringNoteCollectionSeqId] AND mcn_g.[MonitoringNoteTypeId] = 4
  INNER JOIN [Core].[Persons] p ON p.PersonId = collections.SubmittedByPersonId
  INNER JOIN [Compliance].[MonitoringCategories] cat ON cat.MonitoringCategoryId = collections.MonitoringCategoryId
