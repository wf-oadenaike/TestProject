CREATE FUNCTION [wct].[OptionMatrix]
(@CallPut NVARCHAR (4000) NULL, @AssetPrice FLOAT (53) NULL, @StrikePrice FLOAT (53) NULL, @TimeToMaturity FLOAT (53) NULL, @RiskFreeRate FLOAT (53) NULL, @DividendRate FLOAT (53) NULL, @Volatility FLOAT (53) NULL, @ReturnValue NVARCHAR (4000) NULL, @AmEur NVARCHAR (4000) NULL, @Row NVARCHAR (4000) NULL, @RowStep FLOAT (53) NULL, @RowNumSteps INT NULL, @Col NVARCHAR (4000) NULL, @ColStep FLOAT (53) NULL, @ColNumSteps INT NULL)
RETURNS 
     TABLE (
        [idx_row] INT        NULL,
        [idx_col] INT        NULL,
        [row]     FLOAT (53) NULL,
        [col]     FLOAT (53) NULL,
        [val]     FLOAT (53) NULL)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OptionMatrix]

