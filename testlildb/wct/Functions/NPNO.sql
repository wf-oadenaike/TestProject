﻿CREATE FUNCTION [wct].[NPNO]
(@SettDate DATETIME NULL, @FirstPayDate DATETIME NULL, @Pmtpyr INT NULL, @NumPmts INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[NPNO]
