﻿CREATE FUNCTION [wct].[IMCONJUGATE]
(@inumber NVARCHAR (4000) NULL)
RETURNS NVARCHAR (4000)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[IMCONJUGATE]

