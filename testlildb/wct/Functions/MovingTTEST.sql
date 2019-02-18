CREATE FUNCTION [wct].[MovingTTEST]
(@X FLOAT (53) NULL, @Y FLOAT (53) NULL, @TAILS INT NULL, @TTYPE INT NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL, @Exact BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingTTEST]

