﻿CREATE TABLE [dbo].[T_DS_DATA_CHANNEL] (
    [DataChannelID]           INT           NOT NULL,
    [DataChannelName]         VARCHAR (60)  NOT NULL,
    [UpdateDate]              DATETIME      NULL,
    [Description]             VARCHAR (250) NULL,
    [EXPECTED_DELIVERY_TIME]  TIME (7)      NULL,
    [EXPECTED_SLA_COMPLETION] TIME (7)      NULL,
    [SLA_DATE]                DATETIME      CONSTRAINT [DF__T_DS_DATA__SLA_DATE] DEFAULT ((0)) NULL,
    [IS_ACTIVE]               BIT           CONSTRAINT [DF__T_DS_DATA__IS_ACTIVE] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME      CONSTRAINT [DF__T_DS_DATA__CADIS_SYSTEM_INSERTED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME      CONSTRAINT [DF__T_DS_DATA__CADIS_SYSTEM_UPDATED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50) CONSTRAINT [DF__T_DS_DATA__CADIS_SYSTEM_CHANGEDBY] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK__T_DS_DATA_CHANNEL] PRIMARY KEY CLUSTERED ([DataChannelID] ASC) WITH (FILLFACTOR = 90)
);

