CREATE VIEW [Access.ManyWho].[ComplianceMonitoringCategoryNotesSeqReadOnlyVw]
AS
 SELECT     mcn.MonitoringNoteCollectionSeqId
	      , mcn.MonitoringCategoryId
	      , mcn1.CategoryNote as EventDetails
		  , mcn2.CategoryNote as FirstLineResponse
	      , mcn3.CategoryNote as ComplianceConcerns	  
	      , mcn4.CategoryNote as Governance
		  , coalesce(mcn1.occurrencedate,mcn2.occurrencedate,mcn3.occurrencedate,mcn4.occurrencedate) as OccurrenceDate
		  , rpd_uf.PeriodStartDate
		  , rpd_uf.PeriodEndDate
    	  , CASE WHEN mcn1.CategoryNote IS NOT NULL AND mcn2.CategoryNote IS NOT NULL AND mcn3.CategoryNote IS NOT NULL AND mcn4.CategoryNote IS NOT NULL THEN 1 ELSE 0 END as CompleteNotes		  
	FROM (SELECT DISTINCT MonitoringCategoryId,MonitoringNoteCollectionSeqId
	      FROM [Compliance].[MonitoringCategoryNotes]
		  WHERE MonitoringNoteTypeId IS NOT NULL) mcn
	LEFT OUTER JOIN [Compliance].[MonitoringCategoryNotes] mcn1
	ON mcn.MonitoringNoteCollectionSeqId = mcn1.MonitoringNoteCollectionSeqId
	AND mcn.MonitoringCategoryId = mcn1.MonitoringCategoryId
	AND mcn1.MonitoringNoteTypeId=1
	LEFT OUTER JOIN [Compliance].[MonitoringCategoryNotes] mcn2
	ON mcn.MonitoringNoteCollectionSeqId = mcn2.MonitoringNoteCollectionSeqId
	AND mcn.MonitoringCategoryId = mcn2.MonitoringCategoryId
	AND mcn2.MonitoringNoteTypeId=2
	LEFT OUTER JOIN [Compliance].[MonitoringCategoryNotes] mcn3
	ON mcn.MonitoringNoteCollectionSeqId = mcn3.MonitoringNoteCollectionSeqId
	AND mcn.MonitoringCategoryId = mcn3.MonitoringCategoryId
	AND mcn3.MonitoringNoteTypeId=3	
	LEFT OUTER JOIN [Compliance].[MonitoringCategoryNotes] mcn4
	ON mcn.MonitoringNoteCollectionSeqId = mcn4.MonitoringNoteCollectionSeqId
	AND mcn.MonitoringCategoryId = mcn4.MonitoringCategoryId
	AND mcn4.MonitoringNoteTypeId=4
	CROSS APPLY [Compliance].[GetMonitoringReportingPeriodDates_uf] 
	(mcn.MonitoringCategoryId,COALESCE(mcn1.CategoryNoteCreationDate,mcn2.CategoryNoteCreationDate,mcn3.CategoryNoteCreationDate,mcn4.CategoryNoteCreationDate)) AS rpd_uf

;
