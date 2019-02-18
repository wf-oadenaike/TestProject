CREATE FUNCTION [wct].[BinomialTree]
(@CallPut NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @nSteps INT NULL, @AmEur NVARCHAR (4000) NULL)
RETURNS 
     TABLE (
        [node]       INT        NULL,
        [stepno]     INT        NULL,
        [underlying] FLOAT (53) NULL,
        [intrinsic]  FLOAT (53) NULL,
        [price]      FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BinomialTree]

