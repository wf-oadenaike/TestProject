CREATE VIEW "CADIS"."DG_FUNCTION660_RESULTS" AS 
SELECT ET."ID",ET."FundingID",ET."PortfolioID",ET."AllocationAmount" FROM "Investment"."T_UnquotedFundingInitialAllocations" ET WITH (NOLOCK)
