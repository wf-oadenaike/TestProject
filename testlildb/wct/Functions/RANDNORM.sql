﻿CREATE FUNCTION [wct].[RANDNORM]
(@mu FLOAT (53) NULL, @sigma FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RANDNORM]
