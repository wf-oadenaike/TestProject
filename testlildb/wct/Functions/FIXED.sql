﻿CREATE FUNCTION [wct].[FIXED]
(@Number FLOAT (53) NULL, @Decimals INT NULL, @No_commas BIT NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FIXED]

