﻿CREATE FUNCTION [wct].[RECEIVED]
(@Settlement DATETIME NULL, @Maturity DATETIME NULL, @Investment FLOAT (53) NULL, @Discount FLOAT (53) NULL, @Basis NVARCHAR (4000) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[RECEIVED]

