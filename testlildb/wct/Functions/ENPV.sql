﻿CREATE AGGREGATE [wct].[ENPV](@Rate FLOAT (53) NULL, @CF_Amt FLOAT (53) NULL, @Per INT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.ENPV];

