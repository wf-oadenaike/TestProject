﻿CREATE FUNCTION [wct].[BICO]
(@N FLOAT (53) NULL, @K FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BICO]

