﻿CREATE FUNCTION [wct].[AIFACTOR_OLC]
(@Basis NVARCHAR (4000) NULL, @Rate FLOAT (53) NULL, @LastCouponDate DATETIME NULL, @Settlement DATETIME NULL, @MaturityDate DATETIME NULL, @Frequency INT NULL, @Holidays NVARCHAR (MAX) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[AIFACTOR_OLC]

