﻿CREATE AGGREGATE [wct].[COVARIANCE_P](@Known_y FLOAT (53) NULL, @Known_x FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.COVARIANCE_P];
