﻿CREATE FUNCTION [wct].[SWTEST_q]
(@X_RangeQuery NVARCHAR (MAX) NULL, @Statistic NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[SWTEST_q]

