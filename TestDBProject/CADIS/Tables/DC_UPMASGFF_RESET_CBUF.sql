﻿CREATE TABLE [CADIS].[DC_UPMASGFF_RESET_CBUF] (
    [FUND_SHORT_NAME]    VARCHAR (15)  NOT NULL,
    [TRANSACTION_DATE]   DATETIME      NOT NULL,
    [CURRENCY]           VARCHAR (20)  NOT NULL,
    [FUND_FLOW_TYPE]     VARCHAR (20)  NOT NULL,
    [FLOW_TYPE]          VARCHAR (100) NOT NULL,
    [SOURCE_TYPE]        VARCHAR (20)  DEFAULT ('CONFIRMED') NOT NULL,
    [CADIS_SYSTEM_RUNID] INT           NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [CURRENCY] ASC, [FUND_FLOW_TYPE] ASC, [FLOW_TYPE] ASC, [SOURCE_TYPE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CADIS_SYSTEM_RUNID128]
    ON [CADIS].[DC_UPMASGFF_RESET_CBUF]([CADIS_SYSTEM_RUNID] ASC);

