﻿CREATE FUNCTION [wct].[LAPLACE]
(@X FLOAT (53) NULL, @A FLOAT (53) NULL, @B FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LAPLACE]
