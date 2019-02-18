CREATE FUNCTION [wct].[RunningSUM]
(@Val FLOAT (53) NULL, @Round INT NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningSUM]

