﻿CREATE AGGREGATE [wct].[WAVG](@wght FLOAT (53) NULL, @val FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.WAVG];
