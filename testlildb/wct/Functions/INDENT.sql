﻿CREATE FUNCTION [wct].[INDENT]
(@Text NVARCHAR (MAX) NULL, @IndentChars NVARCHAR (4000) NULL, @IndentLevels INT NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[INDENT]

