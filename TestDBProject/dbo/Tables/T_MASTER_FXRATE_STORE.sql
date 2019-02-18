﻿CREATE TABLE [dbo].[T_MASTER_FXRATE_STORE] (
    [STORE_DATE]                DATETIME         NOT NULL,
    [FXRATE_ID]                 VARCHAR (16)     NOT NULL,
    [DATE]                      DATETIME         NOT NULL,
    [FROM_ISO_CURRENCY_CODE]    VARCHAR (3)      NULL,
    [TO_ISO_CURRENCY_CODE]      VARCHAR (3)      NULL,
    [SPOT_RATE]                 DECIMAL (20, 16) NULL,
    [1_MONTH_FORWARD_RATE]      DECIMAL (20, 16) NULL,
    [2_MONTH_FORWARD_RATE]      DECIMAL (20, 16) NULL,
    [3_MONTH_FORWARD_RATE]      DECIMAL (20, 16) NULL,
    [6_MONTH_FORWARD_RATE]      DECIMAL (20, 16) NULL,
    [1_YEAR_FORWARD_RATE]       DECIMAL (20, 16) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__5A19C084] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__5B0DE4BD] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF__T_MASTER___CADIS__5C0208F6] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF__T_MASTER___CADIS__5CF62D2F] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF__T_MASTER___CADIS__5DEA5168] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    CONSTRAINT [PK__T_MASTER__AF71236E87813727] PRIMARY KEY CLUSTERED ([STORE_DATE] ASC, [FXRATE_ID] ASC, [DATE] ASC) WITH (FILLFACTOR = 90)
);

