﻿CREATE AGGREGATE [wct].[TTEST_INDEP](@Label SQL_VARIANT NULL, @Value FLOAT (53) NULL, @Statistic NVARCHAR (4000) NULL, @XLabel SQL_VARIANT NULL)
    RETURNS FLOAT (53)
    EXTERNAL NAME [XLeratorDB_suitePLUS2008].[XLeratorDB_suitePLUS2008.TTEST_INDEP];

