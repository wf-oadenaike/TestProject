﻿CREATE TABLE [CADIS].[DC_EXSFAO_BILLINGCOU_CBUF] (
    [sf_sfaccountid]     VARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([sf_sfaccountid] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID185]
    ON [CADIS].[DC_EXSFAO_BILLINGCOU_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

