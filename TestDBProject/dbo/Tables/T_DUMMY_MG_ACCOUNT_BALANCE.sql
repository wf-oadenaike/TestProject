﻿CREATE TABLE [dbo].[T_DUMMY_MG_ACCOUNT_BALANCE] (
    [FUND_SHORT_NAME]           VARCHAR (15)    NOT NULL,
    [POSITION_DATE]             DATETIME        NOT NULL,
    [ASSET_SUB_CATEGORY]        VARCHAR (100)   NOT NULL,
    [CCY]                       VARCHAR (3)     NOT NULL,
    [LOCAL_VALUE]               DECIMAL (18, 3) NULL,
    [BASE_VALUE]                DECIMAL (18, 3) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF__T_DUMMY_M__CADIS__44C8D28C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF__T_DUMMY_M__CADIS__45BCF6C5] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)   CONSTRAINT [DF__T_DUMMY_M__CADIS__46B11AFE] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF__T_DUMMY_M__CADIS__47A53F37] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF__T_DUMMY_M__CADIS__48996370] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    CONSTRAINT [PK__T_DUMMY___5B124C7FED7811A0] PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [CCY] ASC) WITH (FILLFACTOR = 90)
);

