CREATE FUNCTION [wct].[LAG]
(@Val FLOAT (53) NULL, @Offset INT NULL, @DefaultValue FLOAT (53) NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[LAG]

