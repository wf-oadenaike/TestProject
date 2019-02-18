CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_Accounts_IN] (
    [CADIS_BATCH_ID]            INT            NOT NULL,
    [CADIS_MSG_ID]              INT            CONSTRAINT [DF__T_RuleAud__CADIS__09F919C6] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]           INT            NOT NULL,
    [CADIS_ROW_ID]              INT            NOT NULL,
    [Accounts_CADIS_ROW_ID]     INT            NULL,
    [Evaluation_CADIS_ROW_ID]   INT            NULL,
    [Evaluation_EvalTypeAfter]  NVARCHAR (100) NULL,
    [Evaluation_EvalTypeBefore] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__0AED3DFF] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__0BE16238] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__0CD58671] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF__T_RuleAud__CADIS__0DC9AAAA] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_Accounts_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

