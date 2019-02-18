CREATE VIEW "CADIS"."DG_FUNCTION541_RESULTS" AS 
SELECT ET."Year",ET."Month",ET."ReasonCode",ET."ReasonCodeDescriptive",ET."NoOfInstances" FROM "Access.WebDev"."BERCHistoricalExceptionsByTypeByMonth" ET WITH (NOLOCK)
