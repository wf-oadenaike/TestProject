CREATE VIEW "CADIS"."DG_FUNCTION594_RESULTS" AS 
SELECT ET."Fund",ET."AsOfDate",ET."TMinus1",ET."T",ET."Tplus1",ET."Tplus2",ET."Tplus3",ET."Tplus4",ET."Tplus5",ET."TMinus1_Cash",ET."T_CASH",ET."Tplus1_Cash",ET."Tplus2_Cash",ET."Tplus3_Cash",ET."Tplus4_Cash",ET."Tplus5_Cash" FROM "Access.WebDev"."ufn_NTCashLadderSummaryFundTotal"(NULL) ET
