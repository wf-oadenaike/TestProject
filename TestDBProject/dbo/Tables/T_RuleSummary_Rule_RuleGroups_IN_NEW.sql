﻿CREATE TABLE [dbo].[T_RuleSummary_Rule_RuleGroups_IN_NEW] (
    [CADIS_BATCH_ID]          INT           NOT NULL,
    [CADIS_MSG_ID]            INT           CONSTRAINT [DF__T_RuleSum__CADIS__27F39101] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]         INT           NOT NULL,
    [CADIS_ROW_ID]            INT           NOT NULL,
    [RuleGroups_CADIS_ROW_ID] INT           NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME      CONSTRAINT [DF__T_RuleSum__CADIS__28E7B53A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME      CONSTRAINT [DF__T_RuleSum__CADIS__29DBD973] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50) CONSTRAINT [DF__T_RuleSum__CADIS__2ACFFDAC] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]   INT           CONSTRAINT [DF__T_RuleSum__CADIS__2BC421E5] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_Rule_RuleGroups_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
