CREATE VIEW [Audit].[ManyWhoContentTypesVw]
AS
	SELECT 'ContentString' as ContentType, 'varchar|nvarchar|char|nchar|text|ntext' as Compatible  UNION
	SELECT 'ContentContent' as ContentType, 'varchar|nvarchar|char|nchar|text|ntext' as Compatible   UNION
	SELECT 'ContentPassword' as ContentType, 'varchar|nvarchar|char|nchar|text|ntext' as Compatible   UNION
	SELECT 'ContentNumber' as ContentType, 'Smallint|Int|Bigint|Decimal|Float|Real|Numeric' as Compatible   UNION
	SELECT 'ContentDateTime' as ContentType, 'Date|Datetime|Datetime2|Smalldatetime' as Compatible    UNION
	SELECT 'ContentBoolean' as ContentType, 'bit' as Compatible    UNION
	SELECT 'ContentObject' as ContentType, '' as Compatible    UNION
	SELECT 'ContentList' as ContentType, '' as Compatible   
	;
