﻿CREATE FUNCTION [wct].[FORECAST_q]
(@X FLOAT (53) NULL, @Known_y_Known_x_RangeQuery NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FORECAST_q]

