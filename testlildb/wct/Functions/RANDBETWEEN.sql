﻿CREATE FUNCTION [wct].[RANDBETWEEN]
(@Bottom FLOAT (53) NULL, @Top FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDBETWEEN]
