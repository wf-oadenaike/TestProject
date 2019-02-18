﻿CREATE FUNCTION [wct].[WLS_q]
(@Matrix_RangeQuery NVARCHAR (MAX) NULL, @LConst BIT NULL, @y_Column NVARCHAR (4000) NULL, @w_Column NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [stat_name] NVARCHAR (20)  NULL,
        [idx]       INT            NULL,
        [stat_val]  FLOAT (53)     NULL,
        [col_name]  NVARCHAR (128) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[WLS_q]

