﻿CREATE FUNCTION [wct].[TINV]
(@Probability FLOAT (53) NULL, @Degrees_freedom FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[TINV]

