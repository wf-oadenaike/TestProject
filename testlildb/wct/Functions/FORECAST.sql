﻿CREATE AGGREGATE [wct].[FORECAST](@new_x FLOAT (53) NULL, @known_y FLOAT (53) NULL, @known_x FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.FORECAST];

