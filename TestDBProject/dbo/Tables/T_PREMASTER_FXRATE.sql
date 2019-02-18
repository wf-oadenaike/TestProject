﻿CREATE TABLE [dbo].[T_PREMASTER_FXRATE] (
    [FXRATE_ID]                 VARCHAR (16)     NOT NULL,
    [DATE]                      DATETIME         NOT NULL,
    [FROM_ISO_CURRENCY_CODE]    VARCHAR (3)      NULL,
    [TO_ISO_CURRENCY_CODE]      VARCHAR (3)      NULL,
    [SPOT_RATE]                 DECIMAL (24, 16) NULL,
    [1_MONTH_FORWARD_RATE]      DECIMAL (24, 16) NULL,
    [2_MONTH_FORWARD_RATE]      DECIMAL (24, 16) NULL,
    [3_MONTH_FORWARD_RATE]      DECIMAL (24, 16) NULL,
    [6_MONTH_FORWARD_RATE]      DECIMAL (24, 16) NULL,
    [1_YEAR_FORWARD_RATE]       DECIMAL (24, 16) NULL,
    [DATA_QUALITY]              VARCHAR (20)     NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF__T_PREMAST__CADIS__57D54C48] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF__T_PREMAST__CADIS__58C97081] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF__T_PREMAST__CADIS__59BD94BA] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF__T_PREMAST__CADIS__5AB1B8F3] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF__T_PREMAST__CADIS__5BA5DD2C] DEFAULT (getdate()) NULL,
    [EX_RATE_CHG_PCT]           DECIMAL (20, 10) NULL,
    CONSTRAINT [PK__T_PREMAS__4A56181664FE092D] PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [DATE] ASC) WITH (FILLFACTOR = 90)
);

