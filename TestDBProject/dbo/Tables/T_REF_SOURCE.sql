﻿CREATE TABLE [dbo].[T_REF_SOURCE] (
    [SOURCE]                 VARCHAR (50)  NOT NULL,
    [ACTIVE]                 VARCHAR (1)   CONSTRAINT [DF__T_REF_SOU__ACTIV__28A3C565] DEFAULT ('Y') NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF__T_REF_SOU__CADIS__2997E99E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF__T_REF_SOU__CADIS__2A8C0DD7] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF__T_REF_SOU__CADIS__2B803210] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT           CONSTRAINT [DF__T_REF_SOU__CADIS__2C745649] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP] ROWVERSION    NOT NULL,
    CONSTRAINT [PK__T_REF_SO__7FB6EF692E5C9EBB] PRIMARY KEY CLUSTERED ([SOURCE] ASC) WITH (FILLFACTOR = 90)
);

