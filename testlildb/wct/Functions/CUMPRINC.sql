﻿CREATE FUNCTION [wct].[CUMPRINC]
(@Rate FLOAT (53) NULL, @Nper FLOAT (53) NULL, @PV FLOAT (53) NULL, @Start_period INT NULL, @End_period INT NULL, @Pay_type INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[CUMPRINC]

