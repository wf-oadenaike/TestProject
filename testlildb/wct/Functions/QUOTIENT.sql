﻿CREATE FUNCTION [wct].[QUOTIENT]
(@Numerator FLOAT (53) NULL, @Denominator FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[QUOTIENT]

