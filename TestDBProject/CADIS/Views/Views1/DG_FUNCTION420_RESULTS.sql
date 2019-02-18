CREATE VIEW "CADIS"."DG_FUNCTION420_RESULTS" AS 
SELECT ET."RootCauseId",ET."RootCause",ET."RootCauseDescription" FROM "Access.ManyWho"."ComplaintRootCausesVw" ET WITH (NOLOCK)
