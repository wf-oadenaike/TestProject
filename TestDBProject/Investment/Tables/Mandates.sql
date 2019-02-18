﻿CREATE TABLE [Investment].[Mandates] (
    [MandateId]                   INT              IDENTITY (1, 1) NOT NULL,
    [PortfolioCode]               VARCHAR (20)     NOT NULL,
    [MandateName]                 VARCHAR (128)    NOT NULL,
    [MandateDescription]          VARCHAR (128)    NOT NULL,
    [IsActive]                    BIT              NULL,
    [ClientId]                    INT              NULL,
    [IsWoodfordMandate]           BIT              NULL,
    [IsWeeklyValuationSignOff]    BIT              NULL,
    [IsWeeklyReconciliation]      BIT              NULL,
    [WeeklyValuationSignOffDay]   VARCHAR (10)     NULL,
    [ReconciliationBoxFolderId]   VARCHAR (25)     NULL,
    [JoinGUID]                    UNIQUEIDENTIFIER NOT NULL,
    [MandateCreationDatetime]     DATETIME         CONSTRAINT [DF_MA_MACDT] DEFAULT (getdate()) NOT NULL,
    [MandateLastModifiedDatetime] DATETIME         CONSTRAINT [DF_MA_MALMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME         CONSTRAINT [DF_MA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME         CONSTRAINT [DF_MA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)    CONSTRAINT [DF_MA_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]       INT              CONSTRAINT [DF_MA_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]      ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]   DATETIME         CONSTRAINT [DF_RR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKMandateId] PRIMARY KEY CLUSTERED ([MandateId] ASC),
    CONSTRAINT [MandateClientId] FOREIGN KEY ([ClientId]) REFERENCES [Sales].[ClientRegister] ([ClientId]),
    CONSTRAINT [MandatePortfolioCode] FOREIGN KEY ([PortfolioCode]) REFERENCES [dbo].[T_MASTER_FND] ([SHORT_NAME])
);
