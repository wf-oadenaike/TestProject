﻿CREATE FUNCTION [wct].[NCFPDF]
(@X FLOAT (53) NULL, @DF1 FLOAT (53) NULL, @DF2 FLOAT (53) NULL, @Lambda FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NCFPDF]

