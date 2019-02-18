CREATE  VIEW [Access.ManyWho].[ComplianceMonitoringRecordNotesSeqReadOnlyVw]
AS
SELECT [MonitoringThemeId]
      ,[MonitoringRecordNoteCollectionSeqId]
	  , COUNT(*) as NumberOfOutliers
      ,[EventDetailsNote]
	  ,[FirstLineResponseNote]
      ,[ComplianceConcernsNote]
      ,[GovernanceNote]
	  ,OccurrenceDate
	  ,[ActionRequired]
	  ,JoinGUID
  FROM [Compliance].[MonitoringRecordNotes]
  GROUP BY [MonitoringThemeId]
          ,[MonitoringRecordNoteCollectionSeqId]
          ,[EventDetailsNote]
	      ,[FirstLineResponseNote]
          ,[ComplianceConcernsNote]
          ,[GovernanceNote]
		  ,OccurrenceDate
		  ,[ActionRequired]
		  ,JoinGUID
;
