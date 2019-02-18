﻿CREATE TABLE [Compliance].[StopListRegisterback] (
    [StopListId]                           INT              IDENTITY (1, 1) NOT NULL,
    [StoppedCompanyName]                   NVARCHAR (128)   NOT NULL,
    [Ticker]                               VARCHAR (50)     NULL,
    [BloombergId]                          VARCHAR (30)     NULL,
    [InvestmentStopNumber]                 VARCHAR (25)     NULL,
    [Status]                               VARCHAR (50)     NULL,
    [RequestedDate]                        DATETIME         NOT NULL,
    [AdvisedDate]                          DATETIME         NOT NULL,
    [IsStopRequested]                      BIT              NULL,
    [StoppedDate]                          DATETIME         NULL,
    [IsStopped]                            BIT              NULL,
    [IsCleanseRequested]                   BIT              NULL,
    [IsCleansed]                           BIT              NULL,
    [CleansedDate]                         DATETIME         NULL,
    [SubmittedByPersonId]                  SMALLINT         CONSTRAINT [DF_SLR_SLRSP] DEFAULT ((-1)) NOT NULL,
    [CleanseRequestorPersonId]             SMALLINT         NULL,
    [CleanseRequestDate]                   DATETIME         NULL,
    [AnticipatedCleanseDate]               DATETIME         NULL,
    [DocumentationFolderLink]              VARCHAR (2000)   NULL,
    [JoinGUID]                             UNIQUEIDENTIFIER NOT NULL,
    [StopListRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_SLR_SLRCDT] DEFAULT (getdate()) NOT NULL,
    [StopListRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_SLR_SLRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                DATETIME         CONSTRAINT [DF_SLR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                 DATETIME         CONSTRAINT [DF_SLR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]               NVARCHAR (50)    CONSTRAINT [DF_SLR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                INT              CONSTRAINT [DF_SLR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]               ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]            DATETIME         CONSTRAINT [DF_SLR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKStopListRegister] PRIMARY KEY CLUSTERED ([StopListId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [StopListRegisterCleanseRequestorPersonId] FOREIGN KEY ([CleanseRequestorPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [StopListRegisterSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);
