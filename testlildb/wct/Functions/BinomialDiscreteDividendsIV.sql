CREATE FUNCTION [wct].[BinomialDiscreteDividendsIV]
(@CallPut NVARCHAR (4000) NULL, @AmEur NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Dividend_RangeQuery NVARCHAR (MAX) NULL, @Price FLOAT (53) NULL, @NumberOfSteps INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BinomialDiscreteDividendsIV]

