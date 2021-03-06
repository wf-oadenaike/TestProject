﻿CREATE TABLE [CADIS].[DI_VLRGLMTSUM_VLRGLMTSUM_CBUF] (
    [ROW_ID]             BIGINT NOT NULL,
    [CADIS_SYSTEM_RUNID] INT    NULL,
    PRIMARY KEY CLUSTERED ([ROW_ID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID200]
    ON [CADIS].[DI_VLRGLMTSUM_VLRGLMTSUM_CBUF]([CADIS_SYSTEM_RUNID] ASC) WITH (FILLFACTOR = 80);

