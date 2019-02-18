﻿CREATE TABLE [CADIS_PROC].[DC_UPSJPGFF_SJP_PREP] (
    [ROW_NUMBER]                INT             NOT NULL,
    [TYPE]                      VARCHAR (20)    NOT NULL,
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [TRANSACTION_DATE]          DATETIME        NOT NULL,
    [CURRENCY]                  VARCHAR (20)    NOT NULL,
    [FUND_FLOW_TYPE]            VARCHAR (20)    NOT NULL,
    [FLOW_TYPE]                 VARCHAR (100)   NOT NULL,
    [SETTLEMENT_DATE]           DATETIME        NULL,
    [MARKET_VALUE]              DECIMAL (18, 2) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRANSACTION_DATE] ASC, [CURRENCY] ASC, [FUND_FLOW_TYPE] ASC, [FLOW_TYPE] ASC) WITH (FILLFACTOR = 80)
);

