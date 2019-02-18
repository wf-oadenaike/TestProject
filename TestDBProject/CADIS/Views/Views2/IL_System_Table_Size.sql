CREATE VIEW "CADIS"."IL_System_Table_Size" AS 
SELECT V."SCHEMA_NAME" AS "Schema",V."TABLE_NAME" AS "Table Name",V."ROW_COUNT" AS "Rows",V."SIZE_KB" AS "Size (KB)",V."SIZE_MB" AS "Size (MB)" FROM "CADIS"."VW_System_Table_Sizes" V
