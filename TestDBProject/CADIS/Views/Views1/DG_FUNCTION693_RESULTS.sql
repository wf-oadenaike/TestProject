CREATE VIEW "CADIS"."DG_FUNCTION693_RESULTS" AS 
SELECT ET."HuddleControlLogRelationshipId",ET."HuddleEventId",ET."ControlLogRegisterId",ET."IsActive",ET."JoinGUID",ET."CADIS_SYSTEM_INSERTED",ET."CADIS_SYSTEM_UPDATED",ET."CADIS_SYSTEM_CHANGEDBY" FROM "Organisation"."HuddleControlLogRelationship" ET WITH (NOLOCK)
