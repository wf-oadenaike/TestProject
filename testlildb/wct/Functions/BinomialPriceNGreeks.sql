﻿CREATE FUNCTION [wct].[BinomialPriceNGreeks]
(@CallPut NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @nSteps INT NULL, @AmEur NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [Price]  FLOAT (53) NULL,
        [Delta]  FLOAT (53) NULL,
        [Gamma]  FLOAT (53) NULL,
        [Theta]  FLOAT (53) NULL,
        [Vega]   FLOAT (53) NULL,
        [Rho]    FLOAT (53) NULL,
        [Lambda] FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BinomialPriceNGreeks]

