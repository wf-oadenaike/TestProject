﻿CREATE FUNCTION [wct].[COUNT]
(@TableName NVARCHAR (MAX) NULL, @ColumnName NVARCHAR (4000) NULL, @GroupedColumnName NVARCHAR (4000) NULL, @GroupedColumnValue SQL_VARIANT NULL)
RETURNS INT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[COUNT]
