﻿CREATE AGGREGATE [wct].[XIRR](@CF FLOAT (53) NULL, @CFdate DATETIME NULL, @Guess FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.XIRR];

