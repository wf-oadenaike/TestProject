﻿CREATE TABLE [dbo].[T_MASTER_POS_ACCOUNT_BALANCE] (
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [POSITION_DATE]             DATETIME        NOT NULL,
    [ASSET_SUB_CATEGORY]        VARCHAR (100)   NOT NULL,
    [CCY]                       VARCHAR (3)     NOT NULL,
    [LOCAL_VALUE]               DECIMAL (18, 3) NULL,
    [BASE_VALUE]                DECIMAL (18, 3) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF__T_MASTER___CADIS__79700E47] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF__T_MASTER___CADIS__7A643280] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF__T_MASTER___CADIS__7B5856B9] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF__T_MASTER___CADIS__7C4C7AF2] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF__T_MASTER___CADIS__7D409F2B] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK__T_MASTER__5B124C7F1059D333] PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [CCY] ASC) WITH (FILLFACTOR = 90)
);

