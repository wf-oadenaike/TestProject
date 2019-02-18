﻿CREATE VIEW "CADIS"."DG_FUNCTION453_RESULTS" AS 
SELECT ET."DvdNTHighLevelOverrideEventId",ET."Qtr",ET."SubmittedByPersonId",ET."SubmittedBy",ET."OverrideNetIncome",ET."OverrideUnitsInIssue",ET."DvdRate",ET."OverrideCommentary",ET."OverrideDvdChangeReasonId",ET."OverrideDvdChangeReason",ET."EventDate",ET."JoinGUID",ET."DvdNTHighLevelOverrideEventCreationDatetime",ET."DvdNTHighLevelOverrideEventLastModifiedDatetime" FROM "Access.ManyWho"."DvdNTHighLevelOverrideEventsVw" ET WITH (NOLOCK)
