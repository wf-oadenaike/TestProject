﻿CREATE FUNCTION [wct].[OLC]
(@Rate FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Price FLOAT (53) NULL, @RV FLOAT (53) NULL, @Freq INT NULL, @A FLOAT (53) NULL, @E FLOAT (53) NULL, @DSC FLOAT (53) NULL, @N INT NULL, @ShortLast BIT NULL, @A1 FLOAT (53) NULL, @DSC1 FLOAT (53) NULL, @DLC1 FLOAT (53) NULL, @NLL1 FLOAT (53) NULL, @A2 FLOAT (53) NULL, @DSC2 FLOAT (53) NULL, @DLC2 FLOAT (53) NULL, @NLL2 FLOAT (53) NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OLC]

