CREATE VIEW "CADIS"."IL_Compliance_EBI_Register_Event_Types" AS 
SELECT V."EBIEventTypeId" AS "EBI Event Type Id",V."EBIEventTypeBK" AS "EBI Event Type BK",V."EBIEventDescription" AS "EBI Event Description" FROM "Compliance"."EBIRegisterEventTypes" V
