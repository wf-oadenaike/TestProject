﻿CREATE FUNCTION [wct].[ODDCOMPINT]
(@Basis NVARCHAR (4000) NULL, @Rate FLOAT (53) NULL, @IssueDate DATETIME NULL, @Settlement DATETIME NULL, @Maturity DATETIME NULL, @FirstCouponDate DATETIME NULL, @LastCouponDate DATETIME NULL, @CompFreq INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ODDCOMPINT]

