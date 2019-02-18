CREATE VIEW "CADIS"."DG_FUNCTION174_RESULTS" AS 
SELECT ET."RiskImpactId",ET."ImpactName",ET."ImpactScore",ET."CreatedDate" FROM "Access.ManyWho"."RiskImpactVw" ET WITH (NOLOCK)
