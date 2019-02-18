CREATE TABLE [dbo].[T_RuleSummary_Rule_RuleGroups_RuleGroup_IN_NEW] (
    [CADIS_BATCH_ID]              INT            NOT NULL,
    [CADIS_MSG_ID]                INT            CONSTRAINT [DF__T_RuleSum__CADIS__2EA08E90] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]             INT            NOT NULL,
    [CADIS_ROW_ID]                INT            NOT NULL,
    [RuleGroup_CADIS_ROW_ID]      INT            NULL,
    [RuleGroup_FolderName]        NVARCHAR (100) NULL,
    [RuleGroup_FolderNum]         NVARCHAR (100) NULL,
    [RuleGroup_GroupFolderItemId] NVARCHAR (100) NULL,
    [RuleGroup_RuleGroupName]     NVARCHAR (100) NULL,
    [RuleGroup_RuleGroupNum]      NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]       DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__2F94B2C9] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]        DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__3088D702] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]      NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__317CFB3B] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]       INT            CONSTRAINT [DF__T_RuleSum__CADIS__32711F74] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_RuleGroups_RuleGroup_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

