﻿CREATE FUNCTION [wct].[QUADOSC]
(@Func NVARCHAR (MAX) NULL, @VarName NVARCHAR (4000) NULL, @A SQL_VARIANT NULL, @B SQL_VARIANT NULL, @Omega FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[QUADOSC]
