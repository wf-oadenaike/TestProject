CREATE FUNCTION [wct].[QRdecomp]
(@Matrix_TableName NVARCHAR (MAX) NULL, @Matrix_ColumnNames NVARCHAR (4000) NULL, @Matrix_GroupedColumnName NVARCHAR (4000) NULL, @Matrix_GroupedColumnValue SQL_VARIANT NULL)
RETURNS 
     TABLE (
        [Matrix]    NVARCHAR (2) NULL,
        [RowNum]    INT          NULL,
        [ColNum]    INT          NULL,
        [ItemValue] FLOAT (53)   NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[QRdecomp]

