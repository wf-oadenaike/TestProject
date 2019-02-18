﻿CREATE TABLE [CADIS_PROC].[DC_UPNTDVDIRR_CSTSHT_PREP] (
    [CUR_DATE]               DATE            NULL,
    [DATE]                   DATETIME        NOT NULL,
    [ACCOUNT_NUMBER]         VARCHAR (50)    NOT NULL,
    [NET_INCOME]             DECIMAL (18, 2) NULL,
    [UNITS_IN_ISSUE]         DECIMAL (18, 4) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([DATE] ASC, [ACCOUNT_NUMBER] ASC) WITH (FILLFACTOR = 80)
);
