﻿CREATE FUNCTION [wct].[PV]
(@Rate FLOAT (53) NULL, @Nper FLOAT (53) NULL, @Pmt FLOAT (53) NULL, @FV FLOAT (53) NULL, @Pay_type INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PV]

