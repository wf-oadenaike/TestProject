﻿CREATE FUNCTION [wct].[DEC2BIN]
(@Number FLOAT (53) NULL, @Places FLOAT (53) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[DEC2BIN]
