CREATE FUNCTION [wct].[MTRACE]
(@Matrix_TableName NVARCHAR (MAX) NULL, @ColumnNames NVARCHAR (MAX) NULL, @GroupedColumnName NVARCHAR (4000) NULL, @GroupedColumnValue SQL_VARIANT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MTRACE]

