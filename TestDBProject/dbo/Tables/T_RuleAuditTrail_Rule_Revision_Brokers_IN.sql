CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_Brokers_IN] (
    [CADIS_BATCH_ID]            INT            NOT NULL,
    [CADIS_MSG_ID]              INT            CONSTRAINT [DF__T_RuleAud__CADIS__10A61755] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]           INT            NOT NULL,
    [CADIS_ROW_ID]              INT            NOT NULL,
    [Brokers_CADIS_ROW_ID]      INT            NULL,
    [Evaluation_CADIS_ROW_ID]   INT            NULL,
    [Evaluation_EvalTypeAfter]  NVARCHAR (100) NULL,
    [Evaluation_EvalTypeBefore] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__119A3B8E] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__128E5FC7] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__13828400] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF__T_RuleAud__CADIS__1476A839] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_Brokers_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

