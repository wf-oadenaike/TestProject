CREATE FUNCTION "CADIS"."IL_NT_Cash_Ladder_Summary_Fund_Total" (
@TDate DATE
)
RETURNS TABLE AS RETURN (
SELECT V."Fund" AS "Fund",V."AsOfDate" AS "As Of Date",V."TMinus1" AS "Open Cash Balance",V."T" AS "T",V."Tplus1" AS "T plus 1",V."Tplus2" AS "T plus 2",V."Tplus3" AS "T plus 3",V."Tplus4" AS "T plus 4",V."Tplus5" AS "T plus 5" FROM "Access.WebDev"."ufn_NTCashLadderSummaryFundTotal"(@TDate) V
)
