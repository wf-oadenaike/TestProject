﻿CREATE FUNCTION [wct].[RunningKURT_P]
(@X FLOAT (53) NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningKURT_P]
