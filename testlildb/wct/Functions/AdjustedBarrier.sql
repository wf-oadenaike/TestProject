CREATE FUNCTION [wct].[AdjustedBarrier]
(@AssetPrice FLOAT (53) NULL, @BarrierPrice FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @Frequency NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AdjustedBarrier]

