﻿CREATE FUNCTION [wct].[BRENT]
(@Func NVARCHAR (MAX) NULL, @VarName NVARCHAR (4000) NULL, @A FLOAT (53) NULL, @B FLOAT (53) NULL, @MaxIter INT NULL, @tol FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[BRENT]

