﻿CREATE AGGREGATE [wct].[SpecificRisk](@Ra FLOAT (53) NULL, @Rb FLOAT (53) NULL, @Rf FLOAT (53) NULL, @Freq INT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.SpecificRisk];

