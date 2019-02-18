CREATE FUNCTION [wct].[MovingVOLATILITY]
(@Price FLOAT (53) NULL, @Scale FLOAT (53) NULL, @Offset INT NULL, @RowNum INT NULL, @Id TINYINT NULL, @Exact BIT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[MovingVOLATILITY]

