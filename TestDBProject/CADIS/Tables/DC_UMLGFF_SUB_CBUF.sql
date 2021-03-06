﻿CREATE TABLE [CADIS].[DC_UMLGFF_SUB_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (15) NOT NULL,
    [TRADE_DATE]         DATETIME     NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRADE_DATE] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID181]
    ON [CADIS].[DC_UMLGFF_SUB_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

