﻿CREATE FUNCTION [wct].[KAPPA_FLEISS]
(@InputData_RangeQuery NVARCHAR (MAX) NULL, @RV NVARCHAR (4000) NULL, @Rating SQL_VARIANT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[KAPPA_FLEISS]

