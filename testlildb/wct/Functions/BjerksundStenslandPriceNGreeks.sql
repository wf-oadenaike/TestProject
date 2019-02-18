CREATE FUNCTION [wct].[BjerksundStenslandPriceNGreeks]
(@CallPut NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL)
RETURNS 
     TABLE (
        [Price]              FLOAT (53) NULL,
        [Delta]              FLOAT (53) NULL,
        [Gamma]              FLOAT (53) NULL,
        [Theta]              FLOAT (53) NULL,
        [Vega]               FLOAT (53) NULL,
        [Rho]                FLOAT (53) NULL,
        [Lambda]             FLOAT (53) NULL,
        [GammaP]             FLOAT (53) NULL,
        [DdeltaDtime]        FLOAT (53) NULL,
        [DdeltaDvol]         FLOAT (53) NULL,
        [DdeltaDvolDvol]     FLOAT (53) NULL,
        [DgammaDvol]         FLOAT (53) NULL,
        [DvegaDvol]          FLOAT (53) NULL,
        [VegaP]              FLOAT (53) NULL,
        [PhiRho2]            FLOAT (53) NULL,
        [DgammaDspot]        FLOAT (53) NULL,
        [DeltaX]             FLOAT (53) NULL,
        [RiskNeutralDensity] FLOAT (53) NULL,
        [DvommaDvol]         FLOAT (53) NULL,
        [DgammaDtime]        FLOAT (53) NULL,
        [DvegaDtime]         FLOAT (53) NULL,
        [ForwardPrice]       FLOAT (53) NULL,
        [ForwardPoints]      FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BjerksundStenslandPriceNGreeks]

