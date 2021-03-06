﻿CREATE TABLE [dbo].[T_BBG_CASH] (
    [FILE_NAME]              VARCHAR (50)  NULL,
    [FILE_TYPE]              VARCHAR (10)  NULL,
    [FILE_DATE]              DATETIME      NULL,
    [NUMBER_OF_FIELDS]       VARCHAR (10)  NULL,
    [FUND_NAME]              VARCHAR (20)  NOT NULL,
    [ISO_CURRENCY_CODE]      VARCHAR (3)   NOT NULL,
    [TRADE_DATE_CASH]        VARCHAR (50)  NULL,
    [SETTLE_DATE_CASH]       VARCHAR (50)  NULL,
    [TRADE_DATE_MARGIN_CASH] VARCHAR (20)  NULL,
    [SETTLEDATE_MARGIN_CASH] VARCHAR (20)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_BBG_CAS__CADIS__26D2223A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_BBG_CAS__CADIS__27C64673] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_BBG_CAS__CADIS__28BA6AAC] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_BBG_CAS__CADIS__29AE8EE5] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_BBG_CA__D81C826E84A1F1D5] PRIMARY KEY CLUSTERED ([FUND_NAME] ASC, [ISO_CURRENCY_CODE] ASC) WITH (FILLFACTOR = 90)
);

