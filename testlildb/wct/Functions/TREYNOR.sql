﻿CREATE AGGREGATE [wct].[TREYNOR](@R FLOAT (53) NULL, @RB FLOAT (53) NULL, @RF FLOAT (53) NULL, @Scale FLOAT (53) NULL, @Geometric BIT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.TREYNOR];

