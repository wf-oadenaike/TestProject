﻿CREATE FUNCTION [wct].[ODDFIPMT]
(@Rate FLOAT (53) NULL, @Per INT NULL, @Nper INT NULL, @PV FLOAT (53) NULL, @FV FLOAT (53) NULL, @FirstPeriod FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[ODDFIPMT]

