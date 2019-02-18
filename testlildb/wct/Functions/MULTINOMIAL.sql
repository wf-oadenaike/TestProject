CREATE FUNCTION [wct].[MULTINOMIAL]
(@Values_TableName NVARCHAR (MAX) NULL, @Values_ColumnName NVARCHAR (4000) NULL, @Values_GroupedColumnName NVARCHAR (4000) NULL, @Values_GroupedColumnValue SQL_VARIANT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MULTINOMIAL]

