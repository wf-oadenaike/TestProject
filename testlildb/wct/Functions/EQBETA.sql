﻿CREATE AGGREGATE [wct].[EQBETA](@PDate DATETIME NULL, @PValue FLOAT (53) NULL, @BValue FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.EQBETA];

