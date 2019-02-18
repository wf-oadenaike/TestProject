﻿CREATE TABLE [CADIS_PROC].[DC_UPMSTFX_OVR_APP_PREP] (
    [FXRATE_ID]                 VARCHAR (6)      NOT NULL,
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
    [OVERRIDE_COMMENT]          VARCHAR (255)    NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([FXRATE_ID] ASC, [DATE] ASC) WITH (FILLFACTOR = 80)
);
