CREATE VIEW "CADIS"."DG_FUNCTION705_RESULTS" AS 
SELECT ET."CircleId",ET."CircleName",ET."ParentCircleId",ET."Purpose",ET."Accountability" FROM "Access.ManyWho"."VwNewOrgStructureCircleDetails" ET WITH (NOLOCK)
