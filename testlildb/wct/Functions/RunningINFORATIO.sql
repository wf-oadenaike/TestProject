CREATE FUNCTION [wct].[RunningINFORATIO]
(@R FLOAT (53) NULL, @Rb FLOAT (53) NULL, @Scale FLOAT (53) NULL, @Prices BIT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningINFORATIO]

