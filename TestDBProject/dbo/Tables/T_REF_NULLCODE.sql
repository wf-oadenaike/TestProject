﻿CREATE TABLE [dbo].[T_REF_NULLCODE] (
    [SOURCE]                 NVARCHAR (50) NOT NULL,
    [CODE]                   NVARCHAR (50) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([SOURCE] ASC, [CODE] ASC) WITH (FILLFACTOR = 90)
);
