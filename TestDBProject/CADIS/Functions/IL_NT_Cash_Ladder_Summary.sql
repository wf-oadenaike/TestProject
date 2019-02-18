CREATE FUNCTION "CADIS"."IL_NT_Cash_Ladder_Summary" (
@TDate DATE
, @Fund VARCHAR(10)
, @MaxDate DATE
)
RETURNS TABLE AS RETURN (
SELECT V."ReportDate" AS "Report Date",V."Fund" AS "Fund",V."CCY" AS "Currency",V."CCY_NAME" AS "Currency Name",V."AsOfDate" AS "As Of Date",V."T_NARR_LONG",V."A_TRAN_AMT",V."ValueGBP" AS "Value (GBP)",V."FxSpotRate" AS "Fx Spot Rate" FROM "Access.WebDev"."ufn_NTCashLadderSummary"(@TDate, @Fund, @MaxDate) V
)
