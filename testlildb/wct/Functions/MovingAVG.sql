CREATE FUNCTION [wct].[MovingAVG]
(@Val FLOAT (53) NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingAVG]

