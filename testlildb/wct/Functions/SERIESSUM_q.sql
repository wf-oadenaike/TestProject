﻿CREATE FUNCTION [wct].[SERIESSUM_q]
(@x FLOAT (53) NULL, @n FLOAT (53) NULL, @m FLOAT (53) NULL, @a_RangeQuery NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SERIESSUM_q]

