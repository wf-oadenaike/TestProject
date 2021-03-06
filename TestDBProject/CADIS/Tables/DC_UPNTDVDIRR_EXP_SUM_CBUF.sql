﻿CREATE TABLE [CADIS].[DC_UPNTDVDIRR_EXP_SUM_CBUF] (
    [CUR_DATE]           DATE         NOT NULL,
    [ACCOUNT_NUMBER]     VARCHAR (50) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([CUR_DATE] ASC, [ACCOUNT_NUMBER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID142]
    ON [CADIS].[DC_UPNTDVDIRR_EXP_SUM_CBUF]([CADIS_SYSTEM_RUNID] ASC);

