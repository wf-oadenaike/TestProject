CREATE VIEW "CADIS"."DG_FUNCTION380_RESULTS" AS 
SELECT ET."SHORT_NAME",ET."PortfolioName",ET."AllocationAmount",ET."AllocationPercent",ET."AllocationBasisPoints",ET."NumberOfShares",ET."VotingRights",ET."CurrencyCode" FROM "Access.ManyWho"."PortfolioPlacingAllocationsVw" ET WITH (NOLOCK)
