CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_RuleGroups_RuleGroup_IN] (
    [CADIS_BATCH_ID]                INT            NOT NULL,
    [CADIS_MSG_ID]                  INT            CONSTRAINT [DF__T_RuleAud__CADIS__0222EDD4] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]               INT            NOT NULL,
    [CADIS_ROW_ID]                  INT            NOT NULL,
    [RuleGroup_CADIS_ROW_ID]        INT            NULL,
    [RuleGroup_RuleGroupNameAfter]  NVARCHAR (100) NULL,
    [RuleGroup_RuleGroupNameBefore] NVARCHAR (100) NULL,
    [RuleGroup_FolderNameAfter]     NVARCHAR (100) NULL,
    [RuleGroup_FolderNameBefore]    NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]         DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__0317120D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]          DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__040B3646] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]        NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__04FF5A7F] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]         INT            CONSTRAINT [DF__T_RuleAud__CADIS__05F37EB8] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_RuleGroups_RuleGroup_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

