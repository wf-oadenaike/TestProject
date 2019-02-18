﻿CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_RuleAud__CADIS__2B5A0D91] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Rule_CADIS_ROW_ID]      INT            NULL,
    [Rule_RuleId]            NVARCHAR (100) NULL,
    [Rule_TemplateReference] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__2C4E31CA] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__2D425603] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__2E367A3C] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_RuleAud__CADIS__2F2A9E75] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);
