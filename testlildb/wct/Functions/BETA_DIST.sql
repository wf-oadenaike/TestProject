﻿CREATE FUNCTION [wct].[BETA_DIST]
(@X FLOAT (53) NULL, @Alpha FLOAT (53) NULL, @Beta FLOAT (53) NULL, @Cumulative BIT NULL, @A FLOAT (53) NULL, @B FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BETA_DIST]

