﻿CREATE TABLE [CADIS].[DC_UPMASTERPR_RESET_CBUF] (
    [EDM_SEC_ID]         INT          NOT NULL,
    [PRICE_TYPE]         VARCHAR (50) NOT NULL,
    [PRICE_DATE]         DATETIME     NOT NULL,
    [CADIS_SYSTEM_RUNID] INT          NULL,
    PRIMARY KEY CLUSTERED ([EDM_SEC_ID] ASC, [PRICE_TYPE] ASC, [PRICE_DATE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID114]
    ON [CADIS].[DC_UPMASTERPR_RESET_CBUF]([CADIS_SYSTEM_RUNID] ASC);

