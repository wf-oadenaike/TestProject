﻿CREATE FUNCTION [wct].[PRICEMAT]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Issue DATETIME NULL, @Rate FLOAT (53) NULL, @Yld FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PRICEMAT]
