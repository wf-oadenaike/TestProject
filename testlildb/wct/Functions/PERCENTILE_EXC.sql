﻿CREATE AGGREGATE [wct].[PERCENTILE_EXC](@x FLOAT (53) NULL, @k FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.PERCENTILE_EXC];

