﻿CREATE TABLE [CADIS_SYS].[CO_GROUPFILTER] (
    [GROUPID]     INT NOT NULL,
    [COMPONENTID] INT NOT NULL,
    CONSTRAINT [PK_CO_GROUPFILTER] PRIMARY KEY CLUSTERED ([GROUPID] ASC, [COMPONENTID] ASC),
    CONSTRAINT [FK_CO_GROUPFILTER_CO_GROUP] FOREIGN KEY ([GROUPID]) REFERENCES [CADIS_SYS].[CO_GROUP] ([GROUPID])
);
