﻿CREATE FUNCTION [wct].[COMPLEX]
(@Real_num FLOAT (53) NULL, @i_num FLOAT (53) NULL, @Suffix NVARCHAR (4000) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[COMPLEX]
