CREATE FUNCTION [wct].[LUdecomp]
(@Matrix_TableName NVARCHAR (MAX) NULL, @Matrix_ColumnNames NVARCHAR (4000) NULL, @Matrix_GroupedColumnName NVARCHAR (4000) NULL, @Matrix_GroupedColumnValue SQL_VARIANT NULL)
RETURNS 
     TABLE (
        [RowNum] INT          NULL,
        [ColNum] INT          NULL,
        [Value]  FLOAT (53)   NULL,
        [Type]   NVARCHAR (2) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LUdecomp]

