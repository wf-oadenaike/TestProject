CREATE VIEW "CADIS"."IL_Audit_Control_Log_Frequency" AS 
SELECT V."ControlLogFrequencyId" AS "Control Log Frequency ID",V."FrequencyName" AS "Frequency Name",V."DisplayOrder" AS "Display Order",V."CADIS_SYSTEM_INSERTED",V."CADIS_SYSTEM_UPDATED",V."CADIS_SYSTEM_CHANGEDBY",V."CADIS_SYSTEM_PRIORITY",V."CADIS_SYSTEM_TIMESTAMP",V."CADIS_SYSTEM_LASTMODIFIED" FROM "Audit"."ControlLogFrequency" V
