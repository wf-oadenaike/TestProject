﻿CREATE FUNCTION [wct].[MTRIL]
(@Matrix NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[MTRIL]

