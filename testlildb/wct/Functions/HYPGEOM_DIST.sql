﻿CREATE FUNCTION [wct].[HYPGEOM_DIST]
(@Sample_s FLOAT (53) NULL, @Number_sample FLOAT (53) NULL, @Population_s FLOAT (53) NULL, @Number_population FLOAT (53) NULL, @Cumulative BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[HYPGEOM_DIST]

