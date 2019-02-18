CREATE VIEW "CADIS"."DM_PARTY_BBG_BROKER_OUT" AS 
SELECT
    MP.CADISID 		as "CADIS Id", 
    MP.CADISPRIORITY	as "CADIS Priority", 
    SR.*, 
    MP.CADISINSERTED 	as "CADIS Inserted", 
    MP.CADISUPDATED 	as "CADIS Updated", 
    MP.CADISCHANGEDBY	as "CADIS Changed By", 
    MP.CADISROWID      as "CADIS Row Id", 
    0                   as "CADIS Revision" 
    FROM "CADIS_PROC"."DM_MP1_SOURCE5" MP 
        INNER JOIN "dbo"."T_BBG_BROKER" SR	
           ON MP."BROKER" = SR."BROKER"
