﻿CREATE FUNCTION [wct].[R78PAYOFF]
(@IntAmt FLOAT (53) NULL, @NumPmts INT NULL, @PeriodNo INT NULL, @Pmt FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[R78PAYOFF]

