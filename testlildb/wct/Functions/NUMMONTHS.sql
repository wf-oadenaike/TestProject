﻿CREATE FUNCTION [wct].[NUMMONTHS]
(@StartDate DATETIME NULL, @EndDate DATETIME NULL)
RETURNS INT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NUMMONTHS]
