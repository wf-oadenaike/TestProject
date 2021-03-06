﻿CREATE TABLE [CADIS_SYS].[CO_EDMGROUPMEMBER] (
    [ID]       INT              IDENTITY (1, 1) NOT NULL,
    [PARENTID] UNIQUEIDENTIFIER NOT NULL,
    [CHILDID]  UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_CO_EDMGROUPMEMBER] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_CO_EDMGROUPMEMBER_CHILDID] FOREIGN KEY ([CHILDID]) REFERENCES [CADIS_SYS].[CO_EDMGROUP] ([ID]),
    CONSTRAINT [FK_CO_EDMGROUPMEMBER_PARENTID] FOREIGN KEY ([PARENTID]) REFERENCES [CADIS_SYS].[CO_EDMGROUP] ([ID])
);

