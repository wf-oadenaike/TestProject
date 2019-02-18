﻿CREATE TABLE [Investment].[MarketCommentary] (
    [CommentaryId]              INT              IDENTITY (1, 1) NOT NULL,
    [CommentaryDate]            DATETIME         NOT NULL,
    [WEIFCOD]                   DECIMAL (19, 5)  NOT NULL,
    [BenchMarkCOD]              DECIMAL (19, 5)  NOT NULL,
    [WPCTCOD]                   DECIMAL (19, 5)  NOT NULL,
    [WIMIFFCOD]                 DECIMAL (19, 5)  NULL,
    [WIMIFFBenchmarkCOD]        DECIMAL (19, 5)  NULL,
    [SharePriceClose]           DECIMAL (19, 5)  NOT NULL,
    [NAVClose]                  DECIMAL (19, 5)  NOT NULL,
    [Commentary]                NVARCHAR (MAX)   NOT NULL,
    [SubmittedByPersonId]       SMALLINT         NOT NULL,
    [DocumentationFolderLink]   VARCHAR (2000)   NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_MC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_MC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_MC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_MC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_MC_CSL] DEFAULT (getdate()) NULL,
    [CommentaryType]            NVARCHAR (24)    NULL,
    CONSTRAINT [PKMarketCommentary] PRIMARY KEY CLUSTERED ([CommentaryId] ASC),
    CONSTRAINT [MarketCommentarySubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);
