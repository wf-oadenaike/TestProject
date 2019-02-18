﻿CREATE TABLE [dbo].[T_NT_FAILED_TRADE_REPORT_IN] (
    [FILE_NAME]              VARCHAR (100)   NULL,
    [FILE_DATE]              DATETIME        NULL,
    [FILE_TYPE]              VARCHAR (20)    NULL,
    [AS_AT_DATE]             DATETIME        NOT NULL,
    [IM_REFERENCE]           INT             NOT NULL,
    [IM_REFERENCE_TYPE]      VARCHAR (1)     NOT NULL,
    [IM_ACCOUNT_ID]          VARCHAR (10)    NULL,
    [QUANTITY]               DECIMAL (28, 2) NULL,
    [TRADE_DATE]             DATETIME        NULL,
    [SETTLEMENT_DATE]        DATETIME        NULL,
    [FS_AGE_ACTUAL]          INT             NULL,
    [ASD]                    DATETIME        NULL,
    [SIDE]                   VARCHAR (4)     NULL,
    [ISIN]                   VARCHAR (12)    NULL,
    [SECURITY_NAME]          VARCHAR (100)   NULL,
    [ASSET_TYPE]             VARCHAR (20)    NULL,
    [NET_MONEY]              DECIMAL (28, 2) NULL,
    [SETTLEMENT_CURR]        VARCHAR (3)     NULL,
    [CUSTODIAN]              VARCHAR (100)   NULL,
    [BROKER]                 VARCHAR (100)   NULL,
    [IM_INTERNAL_REASON]     VARCHAR (100)   NULL,
    [INTERNAL_NOTES]         VARCHAR (100)   NULL,
    [INTERNAL_NOTES_HISTORY] VARCHAR (MAX)   NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([IM_REFERENCE] ASC, [IM_REFERENCE_TYPE] ASC) WITH (FILLFACTOR = 80)
);

