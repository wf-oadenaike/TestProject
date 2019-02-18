CREATE VIEW "CADIS"."DG_FUNCTION528_RESULTS" AS 
SELECT ET."Fund",ET."AsOfDate",ET."TMinus1",ET."T",ET."Tplus1",ET."Tplus2",ET."Tplus3",ET."Tplus4",ET."Tplus5",ET."PctCash",ET."LastUpdated" FROM "Access.WebDev"."ufn_CashLadderSummaryFundTotal"(NULL) ET
