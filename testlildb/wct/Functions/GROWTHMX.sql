﻿CREATE FUNCTION [wct].[GROWTHMX]
(@TableName NVARCHAR (MAX) NULL, @ColumnNames NVARCHAR (4000) NULL, @GroupedColumnName NVARCHAR (4000) NULL, @GroupedColumnValue SQL_VARIANT NULL, @Y_ColumnNumber INT NULL, @New_x NVARCHAR (MAX) NULL, @Lconst BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[GROWTHMX]

