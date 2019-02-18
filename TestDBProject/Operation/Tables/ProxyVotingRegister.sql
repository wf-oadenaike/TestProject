CREATE TABLE [Operation].[ProxyVotingRegister] (
    [ProxyVotingRegisterId]           INT              IDENTITY (1, 1) NOT NULL,
    [SecurityName]                    VARCHAR (128)    NOT NULL,
    [ISIN]                            CHAR (12)        NULL,
    [VoterPersonId]                   SMALLINT         CONSTRAINT [DF_PVR_VPI] DEFAULT ((-1)) NOT NULL,
    [VoterRoleId]                     SMALLINT         CONSTRAINT [DF_PVR_VRI] DEFAULT ((-1)) NOT NULL,
    [RecorderPersonId]                SMALLINT         NULL,
    [DateFiled]                       DATETIME         CONSTRAINT [DF_PVR_DF] DEFAULT (getdate()) NOT NULL,
    [CoveredByIVISYesNo]              BIT              NULL,
    [ProxyVotingCategory]             VARCHAR (25)     CONSTRAINT [DF_PVR_PVC] DEFAULT ('Unknown') NOT NULL,
    [ProxyVotingStatus]               VARCHAR (50)     NULL,
    [MeetingDate]                     DATETIME         NULL,
    [DeadlineDate]                    DATETIME         NULL,
    [SuggestedDecision]               VARCHAR (2048)   NULL,
    [ActualDecision]                  VARCHAR (2048)   NULL,
    [OperationsNotes]                 VARCHAR (MAX)    NULL,
    [InvestmentNotes]                 VARCHAR (MAX)    NULL,
    [CompletedProxyVoteYesNo]         BIT              NULL,
    [IrrevocableUndertakingYesNo]     BIT              NULL,
    [DocumentationFolderLink]         VARCHAR (2000)   NULL,
    [JoinGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [ProxyVotingCreationDatetime]     DATETIME         CONSTRAINT [DF_PVR_PVCDT] DEFAULT (getdate()) NOT NULL,
    [ProxyVotingLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PVR_PVCLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]           DATETIME         CONSTRAINT [DF_PVR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]            DATETIME         CONSTRAINT [DF_PVR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]          NVARCHAR (50)    CONSTRAINT [DF_CPVR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]           INT              CONSTRAINT [DF_PVR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]          ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]       DATETIME         CONSTRAINT [DF_PVR_CSL] DEFAULT (getdate()) NULL,
    [VoterJiraKey]                    VARCHAR (20)     NULL,
    CONSTRAINT [PKProxyVotingRegister] PRIMARY KEY CLUSTERED ([SecurityName] ASC, [VoterPersonId] ASC, [DateFiled] ASC),
    CONSTRAINT [ProxyVotingRegisterRecorderPersonId] FOREIGN KEY ([RecorderPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProxyVotingRegisterVoterPersonId] FOREIGN KEY ([VoterPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProxyVotingRegisterVoterRoleId] FOREIGN KEY ([VoterRoleId]) REFERENCES [Core].[Roles] ([RoleId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UXIProxyVotingRegister]
    ON [Operation].[ProxyVotingRegister]([ProxyVotingRegisterId] ASC);

