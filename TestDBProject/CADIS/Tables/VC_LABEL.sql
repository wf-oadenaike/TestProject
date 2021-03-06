﻿CREATE TABLE [CADIS].[VC_LABEL] (
    [NAME]                   VARCHAR (200) NOT NULL,
    [ACTIVE]                 BIT           DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    CONSTRAINT [PK_VC_LABEL] PRIMARY KEY CLUSTERED ([NAME] ASC) WITH (FILLFACTOR = 80)
);

