﻿CREATE FUNCTION [wct].[MATRIX2STRING_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MATRIX2STRING_q]

