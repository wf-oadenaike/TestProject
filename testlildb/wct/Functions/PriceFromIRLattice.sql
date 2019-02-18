﻿CREATE FUNCTION [wct].[PriceFromIRLattice]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Rate SQL_VARIANT NULL, @Spread FLOAT (53) NULL, @Redemption FLOAT (53) NULL, @Frequency INT NULL, @Basis NVARCHAR (4000) NULL, @LastCouponDate DATETIME NULL, @FirstCouponDate DATETIME NULL, @IssueDate DATETIME NULL, @CCZero NVARCHAR (MAX) NULL, @CurveType NVARCHAR (4000) NULL, @TradeDate DATETIME NULL, @CurveDayCount NVARCHAR (4000) NULL, @days_notice INT NULL, @CurveInterpMethod NVARCHAR (4000) NULL, @Vol FLOAT (53) NULL, @OptionSched NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PriceFromIRLattice]
