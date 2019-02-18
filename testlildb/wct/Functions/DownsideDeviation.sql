CREATE AGGREGATE [wct].[DownsideDeviation](@R FLOAT (53) NULL, @MAR FLOAT (53) NULL, @Full BIT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.DownsideDeviation];

