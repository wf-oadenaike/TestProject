CREATE VIEW [Access.ManyWho].[ComplianceMonitoringCategoryNotesReadOnlyVw]
	AS 
SELECT
      mcn.MonitoringCategoryNoteId
	, mcn.MonitoringCategoryId
	, mc.CategoryName	
	, mcn.CategoryNote
	, mcn.MonitoringNoteTypeId
	, nt.MonitoringNoteType
	, mcn.ValidFromDate
	, mcn.ValidToDate
	, mcn.SubmittedByPersonId
	, sp.PersonsName as SubmittedBy
	, mcn.SubmittedDate
	, mcn.JoinGUID
	, mcn.CategoryNoteCreationDate
	, mcn.CategoryNoteLastModifiedDate
  FROM [Compliance].[MonitoringCategoryNotes] mcn
  INNER JOIN [Compliance].[MonitoringCategories] mc
  ON mcn.MonitoringCategoryId = mc.MonitoringCategoryId
  INNER JOIN [Compliance].[MonitoringNoteTypes] nt
  ON mcn.MonitoringNoteTypeId = nt.MonitoringNoteTypeId
  LEFT OUTER JOIN [Core].[Persons] sp
  ON mcn.SubmittedByPersonId = sp.PersonId
  ;
