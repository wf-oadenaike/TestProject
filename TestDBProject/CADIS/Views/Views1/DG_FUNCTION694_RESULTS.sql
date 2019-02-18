CREATE VIEW "CADIS"."DG_FUNCTION694_RESULTS" AS 
SELECT ET."HuddleControlLogRelationshipId",ET."HuddleEventId",ET."EventName",ET."DocumentName",ET."ProcedureName",ET."ControlLogRegisterId",ET."IsActive",ET."ControlDescription",ET."CategoryName",ET."ControlFrequency" FROM "Access.ManyWho"."HuddleControlLogRelationshipReadOnlyVw" ET WITH (NOLOCK)
