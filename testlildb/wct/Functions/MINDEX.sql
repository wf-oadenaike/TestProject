﻿CREATE FUNCTION [wct].[MINDEX]
(@Matrix NVARCHAR (MAX) NULL, @m INT NULL, @n INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MINDEX]

