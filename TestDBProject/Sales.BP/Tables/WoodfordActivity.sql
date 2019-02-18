CREATE TABLE [Sales.BP].[WoodfordActivity] (
    [Id]                        INT              IDENTITY (1, 1) NOT NULL,
    [ActAccountId]              INT              NOT NULL,
    [ActDate]                   DATE             NOT NULL,
    [ActLocation]               NVARCHAR (100)   NULL,
    [ActSubject]                NVARCHAR (100)   NULL,
    [ActIsPlanned]              BIT              DEFAULT ((1)) NULL,
    [ActIsActual]               BIT              DEFAULT ((0)) NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_WACT_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_WACT_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_WACT_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_WACT_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_WACT_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [fk_wa_aai] FOREIGN KEY ([ActAccountId]) REFERENCES [Sales.BP].[WoodfordAccount] ([Id])
);

