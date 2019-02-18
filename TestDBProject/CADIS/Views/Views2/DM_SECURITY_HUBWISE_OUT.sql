CREATE VIEW "CADIS"."DM_SECURITY_HUBWISE_OUT" AS 
SELECT
    MP.CADISID 		as "CADIS Id", 
    MP.CADISPRIORITY	as "CADIS Priority", 
    SR.*, 
    MP.CADISINSERTED 	as "CADIS Inserted", 
    MP.CADISUPDATED 	as "CADIS Updated", 
    MP.CADISCHANGEDBY	as "CADIS Changed By", 
    MP.CADISROWID      as "CADIS Row Id", 
    0                   as "CADIS Revision" 
    FROM "CADIS_PROC"."DM_MP2_SOURCE243" MP 
        INNER JOIN "dbo"."vw_HW_POSITIONS" SR	
           ON MP."INSTRUMENT_UII" = SR."INSTRUMENT_UII"
