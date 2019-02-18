CREATE VIEW "CADIS"."VW_System_Table_Sizes"
AS
SELECT 
      s.Name AS "SCHEMA_NAME"
    , t.NAME AS TABLE_NAME
    , p.rows AS ROW_COUNT
    ,(SUM(a.total_pages) * 8) AS SIZE_KB
    ,(SUM(a.total_pages) * 8)/1000.0 AS SIZE_MB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
    AND s.Name <> 'CADIS_SYS'
    AND i.has_filter <> 1
    AND p.rows > 0
GROUP BY 
    t.Name, s.Name, p.Rows
