﻿CREATE TABLE [dbo].[T_USER_GROUP_STAGE] (
    [CLIENT]                 VARCHAR (50)  NOT NULL,
    [USER_NAME]              VARCHAR (250) NOT NULL,
    [GROUPNAME]              VARCHAR (150) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([CLIENT] ASC, [USER_NAME] ASC, [GROUPNAME] ASC) WITH (FILLFACTOR = 80)
);

