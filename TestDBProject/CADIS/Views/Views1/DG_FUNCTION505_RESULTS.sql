CREATE VIEW "CADIS"."DG_FUNCTION505_RESULTS" AS 
SELECT ET."FundShortName",ET."IncomePeriodQtr",ET."IncomePeriodYr",ET."GrossDvdValue",ET."NetDvdValue",ET."Units",ET."OriginalGrossDvdValue",ET."OriginalNetDvdValue",ET."OriginalUnits",ET."DvdRate",ET."TotalDvdRatePerYearFund" FROM "Access.ManyWho"."DividendsQuarterlySummaryVw" ET WITH (NOLOCK)
