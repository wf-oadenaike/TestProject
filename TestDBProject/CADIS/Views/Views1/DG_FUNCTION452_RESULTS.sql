﻿CREATE VIEW "CADIS"."DG_FUNCTION452_RESULTS" AS 
SELECT ET."DvdForecastOverrideEventId",ET."DvdForecastCalcOverrideId",ET."SubmittedByPersonId",ET."SubmittedBy",ET."OverrideExDate",ET."OverrideDvdValue",ET."OverrideSpecialCumShares",ET."OverrideCommentary",ET."OverrideDvdChangeReasonId",ET."OverrideDvdChangeReason",ET."EventDate",ET."JoinGUID",ET."DvdForecastOverrideEventCreationDatetime",ET."DvdForecastOverrideEventLastModifiedDatetime" FROM "Access.ManyWho"."DvdForecastOverrideEventsVw" ET WITH (NOLOCK)
