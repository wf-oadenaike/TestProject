﻿CREATE FUNCTION [wct].[BASE]
(@Number BIGINT NULL, @Radix INT NULL, @MinLength INT NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BASE]
