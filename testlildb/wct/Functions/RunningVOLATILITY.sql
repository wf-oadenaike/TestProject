CREATE FUNCTION [wct].[RunningVOLATILITY]
(@Price FLOAT (53) NULL, @Scale FLOAT (53) NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningVOLATILITY]

