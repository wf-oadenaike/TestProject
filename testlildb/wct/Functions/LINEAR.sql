﻿CREATE AGGREGATE [wct].[LINEAR](@Known_x FLOAT (53) NULL, @Known_y FLOAT (53) NULL, @New_x FLOAT (53) NULL, @Extrapolate BIT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.LINEAR];
