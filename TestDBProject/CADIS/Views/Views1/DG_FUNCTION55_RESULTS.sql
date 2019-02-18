﻿CREATE VIEW "CADIS"."DG_FUNCTION55_RESULTS" AS 
SELECT ET."MonitoringCategoryNoteId",ET."MonitoringCategoryId",ET."CategoryName",ET."CategoryNote",ET."MonitoringNoteTypeId",ET."MonitoringNoteType",ET."ValidFromDate",ET."ValidToDate",ET."SubmittedByPersonId",ET."SubmittedBy",ET."SubmittedDate",ET."JoinGUID",ET."CategoryNoteCreationDate",ET."CategoryNoteLastModifiedDate" FROM "Access.ManyWho"."ComplianceMonitoringCategoryNotesReadOnlyVw" ET WITH (NOLOCK)