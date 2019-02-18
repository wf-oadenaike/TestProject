CREATE AGGREGATE [wct].[OmegaSharpeRatio](@R FLOAT (53) NULL, @MAR FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.OmegaSharpeRatio];

