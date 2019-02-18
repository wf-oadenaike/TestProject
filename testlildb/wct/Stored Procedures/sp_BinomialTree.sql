CREATE PROCEDURE [wct].[sp_BinomialTree]
@CallPut NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @nSteps INT NULL, @AmEur NVARCHAR (4000) NULL
AS EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.StoredProcedures].[sp_BinomialTree]

