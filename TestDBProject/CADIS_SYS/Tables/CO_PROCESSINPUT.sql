﻿CREATE TABLE [CADIS_SYS].[CO_PROCESSINPUT] (
    [INPUTID]               INT            IDENTITY (1, 1) NOT NULL,
    [COMPONENTID]           INT            NOT NULL,
    [PROCESSNAME]           NVARCHAR (260) NOT NULL,
    [INPUTNAME]             NVARCHAR (200) NOT NULL,
    [LASTDATEPROCESSED]     DATETIME       NULL,
    [PROPOSEDDATEPROCESSED] DATETIME       NULL,
    [INSERTED]              DATETIME       DEFAULT (getdate()) NOT NULL,
    [UPDATED]               DATETIME       DEFAULT (getdate()) NOT NULL,
    [OBSOLETE]              BIT            DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_CO_PROCESSINPUT] PRIMARY KEY CLUSTERED ([INPUTID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_CO_COMPONENT_CO_PROCESSINPUT] FOREIGN KEY ([COMPONENTID]) REFERENCES [CADIS_SYS].[CO_COMPONENT] ([ID])
);

