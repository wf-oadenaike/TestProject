CREATE VIEW "CADIS"."DG_FUNCTION95_RESULTS" AS 
SELECT ET."PolicyThemeProcedureId",ET."ControlLogRegisterId",ET."IsActive" FROM "Audit"."ProcedureControlLogRegisterRelationship" ET WITH (NOLOCK)
