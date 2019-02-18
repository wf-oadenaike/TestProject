CREATE VIEW "CADIS"."DG_FUNCTION725_RESULTS" AS 
SELECT ET."CircleId",ET."Name",ET."Purpose",ET."ParentCircleId",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY",ET."Label",ET."IsActive",ET."CircleLead",ET."Facilitator",ET."HasCircleLead",ET."HasFacilitator",ET."ProjectKey" FROM "dbo"."NewOrgStructureCircles" ET WITH (NOLOCK)
