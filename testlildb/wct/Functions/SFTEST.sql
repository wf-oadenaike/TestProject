﻿CREATE AGGREGATE [wct].[SFTEST](@x FLOAT (53) NULL, @statistic NVARCHAR (4000) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.SFTEST];

