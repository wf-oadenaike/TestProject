﻿CREATE TABLE [dbo].[T_OVERRIDE_POS_ACCOUNT_BALANCE_EXPIRY] (
    [FUND_SHORT_NAME]           VARCHAR (15)  NOT NULL,
    [POSITION_DATE]             DATETIME      NOT NULL,
    [ASSET_SUB_CATEGORY]        VARCHAR (100) NOT NULL,
    [CCY]                       VARCHAR (3)   NOT NULL,
    [LOCAL_VALUE]               DATETIME      NULL,
    [BASE_VALUE]                DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__10550A4D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__11492E86] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_OVERRID__CADIS__123D52BF] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_OVERRID__CADIS__133176F8] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF__T_OVERRID__CADIS__14259B31] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    CONSTRAINT [PK__T_OVERRI__5B124C7F5BC7DC07] PRIMARY KEY CLUSTERED ([FUND_SHORT_NAME] ASC, [POSITION_DATE] ASC, [ASSET_SUB_CATEGORY] ASC, [CCY] ASC) WITH (FILLFACTOR = 90)
);

