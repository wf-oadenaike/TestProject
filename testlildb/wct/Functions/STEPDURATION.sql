﻿CREATE FUNCTION [wct].[STEPDURATION]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Yld FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @Coupons NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[STEPDURATION]

