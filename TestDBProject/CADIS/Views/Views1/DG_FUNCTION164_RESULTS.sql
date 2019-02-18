CREATE VIEW "CADIS"."DG_FUNCTION164_RESULTS" AS 
SELECT ET."ShareClassId",ET."MandateId",ET."MandateName",ET."PortfolioCode",ET."ShareClass" FROM "Access.ManyWho"."ShareClassesReadOnlyVw" ET WITH (NOLOCK)
