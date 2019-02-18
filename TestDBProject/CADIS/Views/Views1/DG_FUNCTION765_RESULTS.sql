CREATE VIEW "CADIS"."DG_FUNCTION765_RESULTS" AS 
SELECT ET."Sector",ET."Allocation",ET."Benchmark" FROM "Access.WebSite"."ufn_GetFundSummaryBySectorAllocation"(NULL) ET
