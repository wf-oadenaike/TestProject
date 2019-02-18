CREATE FUNCTION [wct].[CHITEST2]
(@Actual_range_TableName NVARCHAR (MAX) NULL, @AR_ColumnNames NVARCHAR (4000) NULL, @AR_GroupedColumnName NVARCHAR (4000) NULL, @AR_GroupedColumnValue SQL_VARIANT NULL, @Expected_range_TableName NVARCHAR (4000) NULL, @ER_ColumnNames NVARCHAR (4000) NULL, @ER_GroupedColumnName NVARCHAR (4000) NULL, @ER_GroupedColumnValue SQL_VARIANT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CHITEST2]

