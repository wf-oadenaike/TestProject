﻿CREATE FUNCTION [wct].[FACTDOUBLE]
(@Number FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FACTDOUBLE]

