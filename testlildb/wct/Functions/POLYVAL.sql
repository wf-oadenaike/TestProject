﻿CREATE AGGREGATE [wct].[POLYVAL](@known_x FLOAT (53) NULL, @known_y FLOAT (53) NULL, @degree SMALLINT NULL, @new_x FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.POLYVAL];
