﻿CREATE TABLE [CADIS].[DC_UPMSFFLOW_OVERRIDE_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (15)  NOT NULL,
    [TRANSACTION_DATE]   DATETIME      NOT NULL,
    [FLOW_TYPE]          VARCHAR (100) NOT NULL,
    [RECOGNITION_DATE]   DATETIME      NOT NULL,
    [CADIS_SYSTEM_RUNID] INT           NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [FLOW_TYPE] ASC, [RECOGNITION_DATE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID29]
    ON [CADIS].[DC_UPMSFFLOW_OVERRIDE_CBUF]([CADIS_SYSTEM_RUNID] ASC);

