CREATE TABLE [dbo].[T_RuleSummary_Rule_IN_NEW] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_RuleSum__CADIS__0D3F9AC5] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Rule_CADIS_ROW_ID]      INT            NULL,
    [Rule_RuleCurncy]        NVARCHAR (100) NULL,
    [Rule_RuleExpr]          NVARCHAR (100) NULL,
    [Rule_RuleID]            NVARCHAR (100) NULL,
    [Rule_RuleState]         NVARCHAR (100) NULL,
    [Rule_RuleType]          NVARCHAR (100) NULL,
    [Rule_RuleWgtType]       NVARCHAR (100) NULL,
    [Rule_RuleCode]          NVARCHAR (100) NULL,
    [Rule_RuleName]          NVARCHAR (100) NULL,
    [Rule_RuleDesc]          NVARCHAR (100) NULL,
    [Rule_RuleNote]          NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__0E33BEFE] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__0F27E337] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__101C0770] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_RuleSum__CADIS__11102BA9] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

