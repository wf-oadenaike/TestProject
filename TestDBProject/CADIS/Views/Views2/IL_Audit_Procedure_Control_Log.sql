CREATE VIEW "CADIS"."IL_Audit_Procedure_Control_Log" AS 
SELECT V."PolicyThemeProcedureId" AS "Policy Theme Procedure ID",V."ControlLogRegisterId" AS "Control Log Register ID",V."IsActive" AS "Is Active" FROM "Audit"."ProcedureControlLogRegisterRelationship" V
