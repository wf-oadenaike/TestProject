CREATE VIEW "CADIS"."DG_FUNCTION459_RESULTS" AS 
SELECT ET."FundCode",ET."RuleId",ET."Effective_date",ET."Ticker",ET."Identifier",ET."Quantity",ET."Price",ET."MarketValue",ET."InViolation",ET."Weighting" FROM "Access.WebDev"."ufn_RegulatoryDetails"(NULL) ET
