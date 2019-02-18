CREATE FUNCTION "CADIS"."IL_Cash_Ladder_Summary" (
@TDate DATE
, @Fund VARCHAR(10)
, @MaxDate DATE
)
RETURNS TABLE AS RETURN (
SELECT V."ReportDate" AS "Report Date",V."Fund" AS "Fund", J2.DF AS "Currency",V."AsOfDate" AS "As Of Date",V."Value" AS "Value",V."ValueGBP" AS "Value (GBP)",V."FxSpotRate" AS "Fx Spot Rate",V."OVERRIDE" AS "Override" FROM "Access.WebDev"."ufn_CashLadderSummary"(@TDate, @Fund, @MaxDate) V LEFT OUTER JOIN (SELECT DISTINCT "ISO_CCY_CD" AS JF,"ISO_CCY_CD" AS DF FROM "CADIS"."VW_Reference_Currency")  J2 ON  J2.JF=V."CCY"
)
