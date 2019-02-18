CREATE FUNCTION "CADIS"."IL_BBG_Dividend_Forecast" (

)
RETURNS TABLE AS RETURN (
SELECT V."FundShortName" AS "FundShortName",V."EDM_SEC_ID" AS "EDM_SEC_ID",V."CalendarYear" AS "CalendarYear",V."Q1Rate" AS "Q1Rate",V."Q2Rate" AS "Q2Rate",V."Q3Rate" AS "Q3Rate",V."Q4Rate" AS "Q4Rate" FROM "dbo"."ufn_DividendForecast"() V
)
