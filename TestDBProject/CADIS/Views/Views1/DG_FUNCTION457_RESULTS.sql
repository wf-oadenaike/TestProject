CREATE VIEW "CADIS"."DG_FUNCTION457_RESULTS" AS 
SELECT ET."CalendarYear",ET."PrevDvdRate",ET."DvdRate",ET."Change",ET."Target",ET."Shortfall",ET."LastUpdatedDate" FROM "Access.WebDev"."HighlevelDvdRateChangeVw" ET WITH (NOLOCK)
