﻿CREATE FUNCTION [wct].[OFC]
(@Rate FLOAT (53) NULL, @Yield FLOAT (53) NULL, @Price FLOAT (53) NULL, @RV FLOAT (53) NULL, @Freq INT NULL, @E FLOAT (53) NULL, @DSC FLOAT (53) NULL, @N INT NULL, @ShortFirst BIT NULL, @A1 FLOAT (53) NULL, @DFC1 FLOAT (53) NULL, @NLF1 FLOAT (53) NULL, @A2 FLOAT (53) NULL, @DFC2 FLOAT (53) NULL, @NLF2 FLOAT (53) NULL, @Nqf INT NULL)
RETURNS FLOAT (53)
AS
 EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.UserDefinedFunctions].[OFC]

