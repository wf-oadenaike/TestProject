﻿CREATE TABLE [CADIS_SYS].[CO_PROCESSHISTORY] (
    [RUNID]         INT            IDENTITY (1, 1) NOT NULL,
    [COMPONENTID]   INT            NOT NULL,
    [RUNSTART]      DATETIME       NOT NULL,
    [RUNEND]        DATETIME       NULL,
    [RUNSUCCESSFUL] BIT            NOT NULL,
    [LAUNCHEDBY]    NVARCHAR (256) NULL,
    [GUID]          NCHAR (32)     NOT NULL,
    [PARENTRUNID]   INT            NULL,
    [TOPLEVELRUNID] INT            NULL,
    [RETURNCODE]    INT            NULL,
    [RUNPARAMS]     XML            NULL,
    [ITEMID]        NVARCHAR (50)  NULL,
    [FAILEDRUNID]   INT            NULL,
    CONSTRAINT [PK_CO_PROCESSHISTORY] PRIMARY KEY CLUSTERED ([RUNID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_CO_COMPONENT_CO_PROCESSHISTORY] FOREIGN KEY ([COMPONENTID]) REFERENCES [CADIS_SYS].[CO_COMPONENT] ([ID])
);

