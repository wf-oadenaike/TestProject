﻿CREATE TABLE [CADIS_SYS].[CO_GROUP_PROCESS_USER_PERM] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [GUID]        NCHAR (32)     NOT NULL,
    [COMPONENTID] INT            NOT NULL,
    [NAME]        NVARCHAR (200) NOT NULL,
    [USERTYPE]    TINYINT        NOT NULL,
    [PERMISSION]  SMALLINT       NOT NULL,
    [INSERTED]    DATETIME       DEFAULT (getdate()) NULL,
    [UPDATED]     DATETIME       DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CO_GROUP_PROCESS_USER_PERM] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

