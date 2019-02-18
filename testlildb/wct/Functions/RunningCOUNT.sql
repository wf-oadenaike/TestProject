CREATE FUNCTION [wct].[RunningCOUNT]
(@Val SQL_VARIANT NULL, @RowNum INT NULL, @Id TINYINT NULL, @CountNulls BIT NULL)
RETURNS INT
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningCOUNT]

