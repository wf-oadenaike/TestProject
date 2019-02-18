CREATE FUNCTION [wct].[DEMA]
(@Val FLOAT (53) NULL, @Days INT NULL, @Lag INT NULL, @FirstValue NVARCHAR (4000) NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[DEMA]

