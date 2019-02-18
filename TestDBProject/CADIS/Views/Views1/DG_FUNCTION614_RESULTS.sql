CREATE VIEW "CADIS"."DG_FUNCTION614_RESULTS" AS 
SELECT ET."ID",ET."Name",ET."Currency",ET."ISOCode",ET."Symbol",ET."Order",ET."IsActive" FROM "Core"."T_REF_Currencies" ET WITH (NOLOCK)
