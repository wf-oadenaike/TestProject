﻿CREATE FUNCTION [wct].[DIRTYPRICE]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @Issue DATETIME NULL, @FirstCoupon DATETIME NULL, @LastCoupon DATETIME NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[DIRTYPRICE]

