﻿CREATE TABLE [dbo].[T_NT_RO92_PRE] (
    [DATE]                   DATETIME      NULL,
    [ACCOUNT_NUMBER]         VARCHAR (50)  NULL,
    [TYPE]                   VARCHAR (20)  NULL,
    [GEN_LEDGER_ACCOUNT]     VARCHAR (400) NULL,
    [TOTAL_DEBITS]           VARCHAR (400) NULL,
    [TOTAL_CREDITS]          VARCHAR (400) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL
);

