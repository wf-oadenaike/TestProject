﻿CREATE FUNCTION [wct].[DATEFLOAT]
(@Year INT NULL, @Month INT NULL, @Day INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[DATEFLOAT]
