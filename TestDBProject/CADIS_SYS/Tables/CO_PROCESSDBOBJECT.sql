﻿CREATE TABLE [CADIS_SYS].[CO_PROCESSDBOBJECT] (
    [ID]            INT            IDENTITY (1, 1) NOT NULL,
    [COMPONENTTYPE] INT            NOT NULL,
    [GUID]          NCHAR (32)     NOT NULL,
    [DIRECTION]     TINYINT        NOT NULL,
    [TYPE]          TINYINT        NOT NULL,
    [SCHEMA]        NVARCHAR (50)  NOT NULL,
    [NAME]          NVARCHAR (250) NOT NULL,
    [CADISCREATED]  BIT            NOT NULL,
    CONSTRAINT [PK_CO_PROCESSDBOBJECT] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PROCESSDBOBJECT_GUID]
    ON [CADIS_SYS].[CO_PROCESSDBOBJECT]([COMPONENTTYPE] ASC, [GUID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PROCESSDBOBJECT_OBJECT]
    ON [CADIS_SYS].[CO_PROCESSDBOBJECT]([SCHEMA] ASC, [NAME] ASC);
