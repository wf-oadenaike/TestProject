CREATE FUNCTION [wct].[MovingKURT_S]
(@Val FLOAT (53) NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL, @Exact BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingKURT_S]

