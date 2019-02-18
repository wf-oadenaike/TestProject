CREATE TABLE [dbo].[T_MASTER_FUNDING] (
    [FundingID]                INT           IDENTITY (400000000, 1) NOT NULL,
    [EDM_Issuer_ID]            INT           NULL,
    [TypeID]                   INT           NULL,
    [SubTypeID]                INT           NULL,
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
    [FullAllocationsProvided]  BIT           CONSTRAINT [DF_T_MASTER_FUNDING_FullAllocationsProvided] DEFAULT ((0)) NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME      CONSTRAINT [DF_T_MASTER_FUNDING_CADIS_SYSTEM_INSERTED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME      CONSTRAINT [DF_T_MASTER_FUNDING_CADIS_SYSTEM_UPDATED] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   VARCHAR (250) CONSTRAINT [DF_T_MASTER_FUNDING_CADIS_SYSTEM_CHANGEDBY] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_T_MASTER_FUNDING] PRIMARY KEY CLUSTERED ([FundingID] ASC) WITH (FILLFACTOR = 80)
);

