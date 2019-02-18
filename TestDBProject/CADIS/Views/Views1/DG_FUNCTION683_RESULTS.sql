CREATE VIEW "CADIS"."DG_FUNCTION683_RESULTS" AS 
SELECT ET."year",ET."month",ET."totalcommissionbycalendarmonth",ET."AverageCompRateYTD",ET."AverageCompValueYTD",ET."TotalCompValueYTD",ET."totalnotionalvaluebymonth",ET."AccumulativeTotalNotionalValueByMonth",ET."roworder",ET."AsAtDate",ET."AsOfDate" FROM "Access.WebDev"."BERCYearToDateCommissiomMovementVw" ET WITH (NOLOCK)
