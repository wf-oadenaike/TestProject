﻿CREATE FUNCTION [wct].[IMADD]
(@inumber1 NVARCHAR (4000) NULL, @inumber2 NVARCHAR (4000) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[IMADD]

