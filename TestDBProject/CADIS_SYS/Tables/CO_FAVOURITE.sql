﻿CREATE TABLE [CADIS_SYS].[CO_FAVOURITE] (
    [FAVOURITEID] INT            IDENTITY (1, 1) NOT NULL,
    [USERID]      NVARCHAR (100) NOT NULL,
    [PROCESSGUID] NCHAR (32)     NOT NULL,
    [INSERTED]    DATETIME       NOT NULL,
    [UPDATED]     DATETIME       NOT NULL,
    [CHANGEDBY]   NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_CADIS_SYS.CO_FAVOURITE] PRIMARY KEY CLUSTERED ([FAVOURITEID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_CO_FAVOURITE_CO_PROCESS] FOREIGN KEY ([PROCESSGUID]) REFERENCES [CADIS_SYS].[CO_PROCESS] ([GUID]) ON DELETE CASCADE,
    CONSTRAINT [UQ_CADIS_SYS.CO_FAVOURITE] UNIQUE NONCLUSTERED ([USERID] ASC, [PROCESSGUID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_CO_FAVOURITE_USERID]
    ON [CADIS_SYS].[CO_FAVOURITE]([USERID] ASC) WITH (FILLFACTOR = 80);
