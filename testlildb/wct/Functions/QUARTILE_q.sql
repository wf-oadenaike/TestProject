﻿CREATE FUNCTION [wct].[QUARTILE_q]
(@Values_RangeQuery NVARCHAR (MAX) NULL, @Quart FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[QUARTILE_q]

