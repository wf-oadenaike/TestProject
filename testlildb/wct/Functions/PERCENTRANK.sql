﻿CREATE AGGREGATE [wct].[PERCENTRANK](@pop FLOAT (53) NULL, @x FLOAT (53) NULL, @sig INT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.PERCENTRANK];

