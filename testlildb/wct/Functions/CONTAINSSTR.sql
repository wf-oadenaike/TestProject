﻿CREATE FUNCTION [wct].[CONTAINSSTR]
(@Text NVARCHAR (MAX) NULL, @Value NVARCHAR (MAX) NULL, @CaseSensitive BIT NULL)
RETURNS BIT
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CONTAINSSTR]
