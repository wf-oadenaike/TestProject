﻿CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_RuleGroups_IN] (
    [CADIS_BATCH_ID]          INT           NOT NULL,
    [CADIS_MSG_ID]            INT           CONSTRAINT [DF__T_RuleAud__CADIS__175314E4] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]         INT           NOT NULL,
    [CADIS_ROW_ID]            INT           NOT NULL,
    [RuleGroups_CADIS_ROW_ID] INT           NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME      CONSTRAINT [DF__T_RuleAud__CADIS__1847391D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME      CONSTRAINT [DF__T_RuleAud__CADIS__193B5D56] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50) CONSTRAINT [DF__T_RuleAud__CADIS__1A2F818F] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]   INT           CONSTRAINT [DF__T_RuleAud__CADIS__1B23A5C8] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_RuleGroups_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
