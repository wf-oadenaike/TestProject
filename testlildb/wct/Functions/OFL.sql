﻿CREATE FUNCTION [wct].[OFL]
(@Rate FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Price FLOAT (53) NULL, @RV FLOAT (53) NULL, @Freq INT NULL, @A1 FLOAT (53) NULL, @A2 FLOAT (53) NULL, @DSC FLOAT (53) NULL, @E FLOAT (53) NULL, @N INT NULL, @ShortFirst BIT NULL, @ShortLast BIT NULL, @DLC1 FLOAT (53) NULL, @DLC2 FLOAT (53) NULL, @NLL1 FLOAT (53) NULL, @NLL2 FLOAT (53) NULL, @DFC1 FLOAT (53) NULL, @DFC2 FLOAT (53) NULL, @NLF1 FLOAT (53) NULL, @NLF2 FLOAT (53) NULL, @Nqf INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OFL]

