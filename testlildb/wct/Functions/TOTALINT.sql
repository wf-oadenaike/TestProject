﻿CREATE FUNCTION [wct].[TOTALINT]
(@Nper FLOAT (53) NULL, @Pmt FLOAT (53) NULL, @PV FLOAT (53) NULL, @FV FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[TOTALINT]

