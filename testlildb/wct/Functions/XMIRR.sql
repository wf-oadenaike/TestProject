﻿CREATE AGGREGATE [wct].[XMIRR](@CF_Amt FLOAT (53) NULL, @CF_Date DATETIME NULL, @Finance_rate FLOAT (53) NULL, @Reinvest_rate FLOAT (53) NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.XMIRR];

