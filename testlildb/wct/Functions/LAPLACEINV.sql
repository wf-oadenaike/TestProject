﻿CREATE FUNCTION [wct].[LAPLACEINV]
(@P FLOAT (53) NULL, @A FLOAT (53) NULL, @B FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[LAPLACEINV]

