CREATE VIEW "CADIS"."DM_SECURITY_CURRENCY_OUT" AS 
SELECT
    MP.CADISID 		as "CADIS Id", 
    MP.CADISPRIORITY	as "CADIS Priority", 
    SR.*, 
    MP.CADISINSERTED 	as "CADIS Inserted", 
    MP.CADISUPDATED 	as "CADIS Updated", 
    MP.CADISCHANGEDBY	as "CADIS Changed By", 
    MP.CADISROWID      as "CADIS Row Id", 
    0                   as "CADIS Revision" 
    FROM "CADIS_PROC"."DM_MP2_SOURCE21" MP 
        INNER JOIN "dbo"."T_NT_CURRENCY_CODES" SR	
           ON MP."CCY_CODE" = SR."CCY_CODE"
