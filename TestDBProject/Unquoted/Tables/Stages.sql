﻿CREATE TABLE [Unquoted].[Stages] (
    [StageId]                INT           IDENTITY (1, 1) NOT NULL,
    [StageCode]              VARCHAR (300) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      CONSTRAINT [DF_USG_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      CONSTRAINT [DF_USG_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) CONSTRAINT [DF_USG_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKStage] PRIMARY KEY CLUSTERED ([StageId] ASC)
);

