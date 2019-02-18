CREATE FUNCTION [wct].[DWMA]
(@Val FLOAT (53) NULL, @Days INT NULL, @Lag INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[DWMA]

