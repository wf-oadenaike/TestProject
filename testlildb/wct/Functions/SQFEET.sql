﻿CREATE FUNCTION [wct].[SQFEET]
(@Area FLOAT (53) NULL, @From_scale NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SQFEET]

