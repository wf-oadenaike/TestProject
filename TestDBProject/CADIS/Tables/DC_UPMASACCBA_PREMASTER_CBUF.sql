﻿CREATE TABLE [CADIS].[DC_UPMASACCBA_PREMASTER_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (15)  NOT NULL,
    [POSITION_DATE]      DATETIME      NOT NULL,
    [ASSET_SUB_CATEGORY] VARCHAR (100) NOT NULL,
    [CCY]                VARCHAR (3)   NOT NULL,
    [CADIS_SYSTEM_RUNID] INT           NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [CCY] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID75]
    ON [CADIS].[DC_UPMASACCBA_PREMASTER_CBUF]([CADIS_SYSTEM_RUNID] ASC);

