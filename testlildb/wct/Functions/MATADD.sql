﻿CREATE FUNCTION [wct].[MATADD]
(@Matrix1 NVARCHAR (MAX) NULL, @Matrix2 NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MATADD]
