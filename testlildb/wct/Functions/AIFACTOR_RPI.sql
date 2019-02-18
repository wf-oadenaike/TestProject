﻿CREATE FUNCTION [wct].[AIFACTOR_RPI]
(@Basis NVARCHAR (4000) NULL, @Rate FLOAT (53) NULL, @PrevCoupDate DATETIME NULL, @Settlement DATETIME NULL, @NextCoupDate DATETIME NULL, @Frequency INT NULL, @Maturity DATETIME NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AIFACTOR_RPI]

