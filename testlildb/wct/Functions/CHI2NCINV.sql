﻿CREATE FUNCTION [wct].[CHI2NCINV]
(@P FLOAT (53) NULL, @DF FLOAT (53) NULL, @Lambda FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CHI2NCINV]

