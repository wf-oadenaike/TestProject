﻿CREATE FUNCTION [wct].[COUPPCD]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS DATETIME
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[COUPPCD]
