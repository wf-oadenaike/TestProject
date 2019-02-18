CREATE FUNCTION "CADIS"."IL_Trading_Trade_Blotter" (
@TradeDateFrom DATE
, @TradeDateTo DATE
)
RETURNS TABLE AS RETURN (
SELECT V."AsOfTradeDate",V."Fund_Short_Name",V."TradeBuySell",V."Security_Name",V."SecurityCurrencyISOCode",V."TotalTradedAmount",V."SettlementCcyPrincipal_LocalCCY",V."SettlementCcyPrincipal_GBP",V."AveragePrice_LocalCCY",V."Spot_Rate" FROM "Access.WebDev"."ufn_TradingReport"(@TradeDateFrom, @TradeDateTo) V
)
