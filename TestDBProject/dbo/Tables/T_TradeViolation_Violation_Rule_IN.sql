CREATE TABLE [dbo].[T_TradeViolation_Violation_Rule_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_TradeVi__CADIS__7AA1C79D] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Rule_CADIS_ROW_ID]      INT            NULL,
    [Rule_RuleCurncy]        NVARCHAR (100) NULL,
    [Rule_RuleLimit]         NVARCHAR (100) NULL,
    [Rule_RuleType]          NVARCHAR (100) NULL,
    [Rule_RuleWgtType]       NVARCHAR (100) NULL,
    [Rule_RuleCode]          NVARCHAR (100) NULL,
    [Rule_RuleName]          NVARCHAR (100) NULL,
    [Rule_RuleDesc]          NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__7B95EBD6] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__7C8A100F] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_TradeVi__CADIS__7D7E3448] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_TradeVi__CADIS__7E725881] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_Rule_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

