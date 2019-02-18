﻿CREATE VIEW "CADIS"."DG_FUNCTION67_RESULTS" AS 
SELECT ET."MonitoringThemeNoteId",ET."MonitoringThemeId",ET."SubmittedByPersonId",ET."SubmittedDate",ET."ThemeNote",ET."MonitoringNoteTypeId",ET."MonitoringThemeNoteCollectionSeqId",ET."OccurrenceDate",ET."OutlierCount",ET."JoinGUID",ET."MonitoringThemeNotesCreationDatetime",ET."MonitoringThemeNotesLastModifiedDatetime" FROM "Compliance"."MonitoringThemeNotes" ET WITH (NOLOCK)