﻿CREATE FUNCTION [wct].[FDERIV]
(@Func NVARCHAR (MAX) NULL, @VarName NVARCHAR (4000) NULL, @X FLOAT (53) NULL, @N INT NULL, @H FLOAT (53) NULL, @Meth NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[FDERIV]

