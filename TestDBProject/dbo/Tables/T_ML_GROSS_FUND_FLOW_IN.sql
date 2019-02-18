﻿CREATE TABLE [dbo].[T_ML_GROSS_FUND_FLOW_IN] (
    [FILE_NAME]              VARCHAR (20)    NOT NULL,
    [FILE_TYPE]              VARCHAR (20)    NULL,
    [FILE_DATE]              DATETIME        NULL,
    [NT_ACCOUNT_CODE]        VARCHAR (10)    NOT NULL,
    [FUND_SHORT_NAME]        VARCHAR (15)    NOT NULL,
    [PORTFOLIO_NAME]         VARCHAR (100)   NULL,
    [CURRENCY]               VARCHAR (3)     NULL,
    [AMOUNT]                 DECIMAL (18, 2) NULL,
    [TRADE_DATE]             DATETIME        NOT NULL,
    [VALUE_DATE]             DATETIME        NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [TRADE_DATE] ASC) WITH (FILLFACTOR = 80)
);

