﻿CREATE AGGREGATE [wct].[LARGE](@x FLOAT (53) NULL, @k INT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.LARGE];

