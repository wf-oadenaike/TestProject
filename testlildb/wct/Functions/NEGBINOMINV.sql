﻿CREATE FUNCTION [wct].[NEGBINOMINV]
(@P FLOAT (53) NULL, @Number_s FLOAT (53) NULL, @Probability_s FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NEGBINOMINV]

