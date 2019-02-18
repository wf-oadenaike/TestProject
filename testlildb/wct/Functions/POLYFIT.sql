CREATE FUNCTION [wct].[POLYFIT]
(@TableName NVARCHAR (MAX) NULL, @x_ColumnName NVARCHAR (4000) NULL, @y_ColumnName NVARCHAR (4000) NULL, @GroupedColumnName NVARCHAR (4000) NULL, @Matrix_GroupedColumnValue SQL_VARIANT NULL, @n INT NULL)
RETURNS 
     TABLE (
        [coe_num] INT        NULL,
        [coe_val] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[POLYFIT]

