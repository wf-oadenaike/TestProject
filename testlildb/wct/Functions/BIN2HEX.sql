﻿CREATE FUNCTION [wct].[BIN2HEX]
(@Number NVARCHAR (4000) NULL, @Places FLOAT (53) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BIN2HEX]
