﻿CREATE FUNCTION [wct].[RATE]
(@Nper FLOAT (53) NULL, @Pmt FLOAT (53) NULL, @PV FLOAT (53) NULL, @FV FLOAT (53) NULL, @Pay_type INT NULL, @Guess FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RATE]
