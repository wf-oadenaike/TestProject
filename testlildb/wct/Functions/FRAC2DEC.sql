﻿CREATE FUNCTION [wct].[FRAC2DEC]
(@Frac NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FRAC2DEC]

