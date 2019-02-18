CREATE FUNCTION [wct].[RunningEWMA]
(@Val FLOAT (53) NULL, @Alpha FLOAT (53) NULL, @Lag INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningEWMA]

