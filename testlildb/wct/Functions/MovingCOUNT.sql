CREATE FUNCTION [wct].[MovingCOUNT]
(@Val SQL_VARIANT NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL, @CountNulls BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingCOUNT]

