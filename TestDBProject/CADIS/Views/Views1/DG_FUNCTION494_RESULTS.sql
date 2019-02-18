CREATE VIEW "CADIS"."DG_FUNCTION494_RESULTS" AS 
SELECT ET."ReportDate",ET."Fund",ET."CCY",ET."AsOfDate",ET."Value",ET."ValueGBP",ET."FxSpotRate",ET."OVERRIDE" FROM "Access.WebDev"."ufn_CashLadderSummary"(NULL, NULL, NULL) ET
