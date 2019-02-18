CREATE TABLE [dbo].[T_RuleSummary_Rule_Accounts_Scope_IN_NEW] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_RuleSum__CADIS__1A9995E3] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Scope_CADIS_ROW_ID]     INT            NULL,
    [Scope_AccountName]      NVARCHAR (100) NULL,
    [Scope_AccountType]      NVARCHAR (100) NULL,
    [Scope_BrokerName]       NVARCHAR (100) NULL,
    [Scope_BrokerType]       NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__1B8DBA1C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__1C81DE55] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__1D76028E] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_RuleSum__CADIS__1E6A26C7] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_Accounts_Scope_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

