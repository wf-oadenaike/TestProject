﻿CREATE TABLE [CADIS_PROC].[DC_UPBPSDIVHA_CBUF] (
    [STOCK]      VARCHAR (20) NOT NULL,
    [ROW_ID]     INT          NOT NULL,
    [AS_AT_DATE] DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([STOCK] ASC, [ROW_ID] ASC, [AS_AT_DATE] ASC) WITH (FILLFACTOR = 80)
);

