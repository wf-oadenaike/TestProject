﻿CREATE FUNCTION [wct].[RunningSKEW_S]
(@X FLOAT (53) NULL, @RowNum INT NULL, @Id TINYINT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_windowing].[XLeratorDB_windowing.UserDefinedFunctions].[RunningSKEW_S]

