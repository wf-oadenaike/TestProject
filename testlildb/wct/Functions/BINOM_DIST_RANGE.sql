﻿CREATE FUNCTION [wct].[BINOM_DIST_RANGE]
(@Trials INT NULL, @Probability_s FLOAT (53) NULL, @Number_s INT NULL, @Number_s2 INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BINOM_DIST_RANGE]

