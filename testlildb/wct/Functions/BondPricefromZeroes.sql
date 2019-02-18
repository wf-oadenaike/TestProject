﻿CREATE FUNCTION [wct].[BondPricefromZeroes]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate SQL_VARIANT NULL, @CurveSpread FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL, @LastCouponDate DATETIME NULL, @FirstCouponDate DATETIME NULL, @IssueDate DATETIME NULL, @CCZero NVARCHAR (MAX) NULL, @CurveType NVARCHAR (4000) NULL, @CurveStartDate DATETIME NULL, @CurveDayCount NVARCHAR (4000) NULL, @CurveFrequency INT NULL, @InterpMethod NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BondPricefromZeroes]

