﻿CREATE AGGREGATE [wct].[GTWRR](@CF FLOAT (53) NULL, @CFdate DATETIME NULL, @MV BIT NULL, @CalcRule INT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.GTWRR];
