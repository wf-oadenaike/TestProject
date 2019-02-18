﻿CREATE TABLE [CADIS].[DC_UPMSFFLOW_NET_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (15)    NOT NULL,
    [RECOGNITION_DATE]   DATETIME        NOT NULL,
    [FLOW_TYPE]          VARCHAR (100)   NOT NULL,
    [NET_AMOUNT_BASE]    DECIMAL (38, 6) NOT NULL,
    [CADIS_SYSTEM_RUNID] INT             NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [RECOGNITION_DATE] ASC, [FLOW_TYPE] ASC, [NET_AMOUNT_BASE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID78]
    ON [CADIS].[DC_UPMSFFLOW_NET_CBUF]([CADIS_SYSTEM_RUNID] ASC);

