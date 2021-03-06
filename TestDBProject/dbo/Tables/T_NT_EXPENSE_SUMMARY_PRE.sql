﻿CREATE TABLE [dbo].[T_NT_EXPENSE_SUMMARY_PRE] (
    [DATE]                   DATETIME      NULL,
    [ACCOUNT_NUMBER]         VARCHAR (50)  NULL,
    [SECURITY]               VARCHAR (100) NULL,
    [DESCRIPTION]            VARCHAR (50)  NULL,
    [EXPENSES_CHARGED]       VARCHAR (20)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL
);

