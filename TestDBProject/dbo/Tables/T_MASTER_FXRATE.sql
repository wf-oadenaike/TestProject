﻿CREATE TABLE [dbo].[T_MASTER_FXRATE] (
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
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__643B232D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__652F4766] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF__T_MASTER___CADIS__66236B9F] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF__T_MASTER___CADIS__67178FD8] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__680BB411] DEFAULT (getdate()) NULL,
    [EX_RATE_CHG_PCT]           DECIMAL (20, 10) NULL,
    CONSTRAINT [PK__T_MASTER__4A561816D9F5F1C5] PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [DATE] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxT_MASTER_FXRATE]
    ON [dbo].[T_MASTER_FXRATE]([DATE] ASC);

