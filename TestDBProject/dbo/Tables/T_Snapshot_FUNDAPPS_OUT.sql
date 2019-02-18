﻿CREATE TABLE [dbo].[T_Snapshot_FUNDAPPS_OUT] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_Snapsho__CADIS__0A5775CB] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Date]                   NVARCHAR (MAX) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_Snapsho__CADIS__0B4B9A04] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_Snapsho__CADIS__0C3FBE3D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_Snapsho__CADIS__0D33E276] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_Snapsho__CADIS__0E2806AF] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_Snapshot_FUNDAPPS_OUT] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
