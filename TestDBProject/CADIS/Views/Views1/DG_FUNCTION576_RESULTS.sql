CREATE VIEW "CADIS"."DG_FUNCTION576_RESULTS" AS 
SELECT ET."SubsectorID",ET."Industry",ET."Supersector",ET."Sector",ET."Subsector",ET."SubsectorDescription",ET."FundManagerName",ET."FundManagerPersonID",ET."InvestmentAnalystName",ET."InvestmentAnalystPersonID" FROM "Investment"."V_REF_IndustryClassificationBenchmark" ET WITH (NOLOCK)
