﻿CREATE FUNCTION [wct].[PPD]
(@SettDate DATETIME NULL, @FirstPayDate DATETIME NULL, @pmtpyr INT NULL, @NumPmts INT NULL)
RETURNS DATETIME
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[PPD]

