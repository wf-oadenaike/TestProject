﻿CREATE FUNCTION [wct].[PADRIGHT]
(@Text NVARCHAR (MAX) NULL, @TotalWidth INT NULL, @PaddingChar NVARCHAR (1) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PADRIGHT]
