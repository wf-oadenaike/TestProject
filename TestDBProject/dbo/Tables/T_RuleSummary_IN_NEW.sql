CREATE TABLE [dbo].[T_RuleSummary_IN_NEW] (
    [CADIS_BATCH_ID]                 INT            NOT NULL,
    [CADIS_MSG_ID]                   INT            CONSTRAINT [DF__T_RuleSum__CADIS__354D8C1F] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                INT            NOT NULL,
    [CADIS_ROW_ID]                   INT            NOT NULL,
    [RuleSummary_CADIS_ROW_ID]       INT            NULL,
    [RuleSummary_Version]            NVARCHAR (100) NULL,
    [RuleSummary_Date]               NVARCHAR (100) NULL,
    [RuleSummary_xmlns]              NVARCHAR (100) NULL,
    [RuleSummary_xmlns:xsi]          NVARCHAR (100) NULL,
    [RuleSummary_xsi:schemaLocation] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__3641B058] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME       CONSTRAINT [DF__T_RuleSum__CADIS__3735D491] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)  CONSTRAINT [DF__T_RuleSum__CADIS__3829F8CA] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]          INT            CONSTRAINT [DF__T_RuleSum__CADIS__391E1D03] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleSummary_IN_NEW] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

