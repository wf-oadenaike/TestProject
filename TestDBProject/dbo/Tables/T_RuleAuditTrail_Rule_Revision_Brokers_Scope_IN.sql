﻿CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_Brokers_Scope_IN] (
    [CADIS_BATCH_ID]          INT            NOT NULL,
    [CADIS_MSG_ID]            INT            CONSTRAINT [DF__T_RuleAud__CADIS__676EF798] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]         INT            NOT NULL,
    [CADIS_ROW_ID]            INT            NOT NULL,
    [Scope_CADIS_ROW_ID]      INT            NULL,
    [Scope_AccountNameAfter]  NVARCHAR (100) NULL,
    [Scope_AccountNameBefore] NVARCHAR (100) NULL,
    [Scope_AccountTypeAfter]  NVARCHAR (100) NULL,
    [Scope_AccountTypeBefore] NVARCHAR (100) NULL,
    [Scope_BrokerNameAfter]   NVARCHAR (100) NULL,
    [Scope_BrokerNameBefore]  NVARCHAR (100) NULL,
    [Scope_BrokerTypeAfter]   NVARCHAR (100) NULL,
    [Scope_BrokerTypeBefore]  NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__68631BD1] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__6957400A] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__6A4B6443] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]   INT            CONSTRAINT [DF__T_RuleAud__CADIS__6B3F887C] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_Brokers_Scope_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

