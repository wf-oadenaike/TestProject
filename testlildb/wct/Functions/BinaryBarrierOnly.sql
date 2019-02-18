﻿CREATE FUNCTION [wct].[BinaryBarrierOnly]
(@BarrierType NVARCHAR (4000) NULL, @CashOrNothing BIT NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @BarrierPrice FLOAT (53) NULL, @Rebate FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @ReturnValue NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BinaryBarrierOnly]

