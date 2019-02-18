CREATE VIEW [Access.ManyWho].[ComplianceMonitoringThemeNotesSeqReadOnlyVw]
AS
    SELECT  mctn.MonitoringThemeNoteCollectionSeqId
	      , mctn.MonitoringCategoryId
	      , mctn.MonitoringThemeId
	      , mtn1.ThemeNote as EventDetails
		  , mtn2.ThemeNote as FirstLineResponse
	      , mtn3.ThemeNote as ComplianceConcerns	  
	      , mtn4.ThemeNote as Governance
		  , COALESCE( mtn1.OutlierCount, mtn2.OutlierCount, mtn3.OutlierCount, mtn4.OutlierCount, 0) as OutlierCount
		  , coalesce(mtn1.occurrencedate,mtn2.occurrencedate,mtn3.occurrencedate,mtn4.occurrencedate) as OccurrenceDate
		  , rpd_uf.PeriodStartDate
		  , rpd_uf.PeriodEndDate		 
		  , CASE WHEN mtn1.ThemeNote IS NOT NULL AND mtn2.ThemeNote IS NOT NULL AND mtn3.ThemeNote IS NOT NULL AND mtn4.ThemeNote IS NOT NULL THEN 1 ELSE 0 END as CompleteNotes
	FROM (SELECT DISTINCT mt.MonitoringCategoryId, mtn.MonitoringThemeId, mtn.MonitoringThemeNoteCollectionSeqId
          FROM [Compliance].[MonitoringThemeNotes] mtn
		  INNER JOIN [Compliance].[MonitoringThemes] mt
		  ON mtn.MonitoringThemeId = mt.MonitoringThemeId
		  WHERE mtn.MonitoringNoteTypeId IS NOT NULL OR mtn.OutlierCount IS NOT NULL) mctn  
	LEFT OUTER JOIN [Compliance].[MonitoringThemeNotes] mtn1
	ON mctn.MonitoringThemeNoteCollectionSeqId = mtn1.MonitoringThemeNoteCollectionSeqId
	AND mctn.MonitoringThemeId = mtn1.MonitoringThemeId
	AND mtn1.MonitoringNoteTypeId=1
	LEFT OUTER JOIN [Compliance].[MonitoringThemeNotes] mtn2
	ON mctn.MonitoringThemeNoteCollectionSeqId = mtn2.MonitoringThemeNoteCollectionSeqId
	AND mctn.MonitoringThemeId = mtn2.MonitoringThemeId
	AND mtn2.MonitoringNoteTypeId=2
	LEFT OUTER JOIN [Compliance].[MonitoringThemeNotes] mtn3
	ON mctn.MonitoringThemeNoteCollectionSeqId = mtn3.MonitoringThemeNoteCollectionSeqId
	AND mctn.MonitoringThemeId = mtn3.MonitoringThemeId
	AND mtn3.MonitoringNoteTypeId=3	
	LEFT OUTER JOIN [Compliance].[MonitoringThemeNotes] mtn4
	ON mctn.MonitoringThemeNoteCollectionSeqId = mtn4.MonitoringThemeNoteCollectionSeqId
	AND mctn.MonitoringThemeId = mtn4.MonitoringThemeId
	AND mtn4.MonitoringNoteTypeId=4
	CROSS APPLY [Compliance].[GetMonitoringReportingPeriodDates_uf] (mctn.MonitoringCategoryId,COALESCE(mtn1.MonitoringThemeNotesCreationDatetime,mtn2.MonitoringThemeNotesCreationDatetime,mtn3.MonitoringThemeNotesCreationDatetime,mtn4.MonitoringThemeNotesCreationDatetime)) AS rpd_uf
	
	;
