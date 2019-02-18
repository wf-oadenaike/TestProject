﻿CREATE VIEW "CADIS"."DG_FUNCTION445_RESULTS" AS 
SELECT ET."FUND_SHORT_NAME",ET."Qtr",ET."DATE",ET."NetIncome",ET."UnitsInIssue",ET."PrevDvdRate",ET."DvdRate",ET."NTFAReconDiff",ET."OverrideNetIncome",ET."OverrideUnitsInIssue",ET."OverrideDvdChangeReasonId",ET."OverrideDvdChangeReason",ET."OverrideCommentary",ET."SubmittedByPersonId",ET."SubmittedBy",ET."TotalDvdRate",ET."IsActive",ET."JoinGUID",ET."DvdNTCalcHighLevelOverrideCreationDatetime",ET."DvdNTCalcHighLevelOverrideLastModifiedDatetime" FROM "Access.ManyWho"."DvdNTCalcHighLevelOverrideVw" ET WITH (NOLOCK)
