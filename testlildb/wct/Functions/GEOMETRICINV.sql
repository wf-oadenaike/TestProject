﻿CREATE FUNCTION [wct].[GEOMETRICINV]
(@CDF FLOAT (53) NULL, @P FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[GEOMETRICINV]

