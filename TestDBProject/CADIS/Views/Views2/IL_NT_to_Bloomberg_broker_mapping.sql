CREATE VIEW "CADIS"."IL_NT_to_Bloomberg_broker_mapping" AS 
SELECT V."ID",V."Broker_ID" AS "Broker ID",V."NT_Broker_Name" AS "NT Broker Name" FROM "dbo"."T_REF_BROKER_MAPPING" V
