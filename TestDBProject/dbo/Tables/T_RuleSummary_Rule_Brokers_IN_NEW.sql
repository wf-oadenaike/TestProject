﻿CREATE TABLE [dbo].[T_RuleSummary_Rule_Brokers_IN_NEW] (
    [CADIS_BATCH_ID]          INT            NOT NULL,
    [CADIS_MSG_ID]            INT            CONSTRAINT [DF__T_RuleSum__CADIS__06929D36] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]         INT            NOT NULL,
    [CADIS_ROW_ID]            INT            NOT NULL,
    [Brokers_CADIS_ROW_ID]    INT            NULL,
    [Evaluation_CADIS_ROW_ID] INT            NULL,
    [Evaluation_EvalType]     NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__0786C16F] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__087AE5A8] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__096F09E1] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]   INT            CONSTRAINT [DF__T_RuleSum__CADIS__0A632E1A] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_Brokers_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
