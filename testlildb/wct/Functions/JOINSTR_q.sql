﻿CREATE FUNCTION [wct].[JOINSTR_q]
(@Separator NVARCHAR (4000) NULL, @MaxItems INT NULL, @Values_RangeQuery NVARCHAR (4000) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[JOINSTR_q]

