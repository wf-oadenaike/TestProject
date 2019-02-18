CREATE VIEW "CADIS"."DG_FUNCTION87_RESULTS" AS 
SELECT ET."MonitoringThemeId",ET."MonitoringRecordNoteCollectionSeqId",ET."NumberOfOutliers",ET."EventDetailsNote",ET."FirstLineResponseNote",ET."ComplianceConcernsNote",ET."GovernanceNote",ET."OccurrenceDate",ET."ActionRequired",ET."JoinGUID" FROM "Access.ManyWho"."ComplianceMonitoringRecordNotesSeqReadOnlyVw" ET WITH (NOLOCK)
