﻿CREATE FUNCTION [wct].[ELCM]
(@Number1 FLOAT (53) NULL, @Number2 FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ELCM]
