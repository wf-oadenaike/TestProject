﻿CREATE FUNCTION [wct].[DIS]
(@DSM FLOAT (53) NULL, @RV FLOAT (53) NULL, @P FLOAT (53) NULL, @D FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[DIS]

