﻿CREATE FUNCTION [wct].[IMPOWER]
(@inumber NVARCHAR (4000) NULL, @Number FLOAT (53) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[IMPOWER]

