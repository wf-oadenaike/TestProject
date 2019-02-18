CREATE TABLE [Investment].[T_UnquotedFundings] (
    [ID]                       INT           IDENTITY (1, 1) NOT NULL,
    [IssuerID]                 INT           NULL,
    [TypeID]                   INT           NULL,
    [SubtypeID]                INT           NULL,
    [StatusID]                 INT           NULL,
    [TradeDate]                DATETIME      NULL,
    [SettlementDate]           DATETIME      NULL,
    [IsLegalCommitment]        BIT           NULL,
    [IsReputationalCommitment] BIT           NULL,
    [FlexBackUnit]             VARCHAR (1)   NULL,
    [FlexBackMagnitude]        INT           NULL,
    [FlexForwardUnit]          VARCHAR (1)   NULL,
    [FlexForwardMagnitude]     INT           NULL,
    [JiraIssueKey]             VARCHAR (20)  NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [FullAllocationsProvided]  BIT           DEFAULT ('0') NULL,
    CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 80)
);

