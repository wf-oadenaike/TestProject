CREATE VIEW "CADIS"."DG_FUNCTION56_RESULTS" AS 
SELECT ET."MonitoringNoteCollectionSeqId",ET."MonitoringCategoryId",ET."EventDetails",ET."FirstLineResponse",ET."ComplianceConcerns",ET."Governance",ET."OccurrenceDate",ET."PeriodStartDate",ET."PeriodEndDate",ET."CompleteNotes" FROM "Access.ManyWho"."ComplianceMonitoringCategoryNotesSeqReadOnlyVw" ET WITH (NOLOCK)
