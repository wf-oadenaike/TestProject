﻿CREATE TABLE [CADIS_SYS].[CO_GROUPUSER] (
    [ID]         INT            IDENTITY (1, 1) NOT NULL,
    [GROUPID]    INT            NOT NULL,
    [NAME]       NVARCHAR (200) NULL,
    [USERTYPE]   TINYINT        NOT NULL,
    [PERMISSION] SMALLINT       NOT NULL,
    CONSTRAINT [PK_CO_GROUPUSER] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CO_GROUPUSER_CO_GROUP] FOREIGN KEY ([GROUPID]) REFERENCES [CADIS_SYS].[CO_GROUP] ([GROUPID])
);
