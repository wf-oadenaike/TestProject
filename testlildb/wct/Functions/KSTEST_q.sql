﻿CREATE FUNCTION [wct].[KSTEST_q]
(@XValues_RangeQuery NVARCHAR (MAX) NULL, @Statistic NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KSTEST_q]

