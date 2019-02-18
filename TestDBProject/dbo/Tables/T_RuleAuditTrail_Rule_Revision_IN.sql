CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_IN] (
    [CADIS_BATCH_ID]            INT            NOT NULL,
    [CADIS_MSG_ID]              INT            CONSTRAINT [DF__T_RuleAud__CADIS__32070B20] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]           INT            NOT NULL,
    [CADIS_ROW_ID]              INT            NOT NULL,
    [Revision_CADIS_ROW_ID]     INT            NULL,
    [Revision_DateTime]         NVARCHAR (100) NULL,
    [Revision_Login]            NVARCHAR (100) NULL,
    [Revision_ModificationType] NVARCHAR (100) NULL,
    [Revision_RevisionNo]       NVARCHAR (100) NULL,
    [Revision_TerminalID]       NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__32FB2F59] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__33EF5392] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__34E377CB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            CONSTRAINT [DF__T_RuleAud__CADIS__35D79C04] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

