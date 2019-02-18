﻿CREATE TABLE [CADIS].[DC_EXSFAO_POSTCODE_CBUF] (
    [sf_sfaccountid]     VARCHAR (18) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([sf_sfaccountid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID156]
    ON [CADIS].[DC_EXSFAO_POSTCODE_CBUF]([CADIS_SYSTEM_RUNID] ASC);

