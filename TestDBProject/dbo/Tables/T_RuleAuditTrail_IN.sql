CREATE TABLE [dbo].[T_RuleAuditTrail_IN] (
    [CADIS_BATCH_ID]                    INT            NOT NULL,
    [CADIS_MSG_ID]                      INT            CONSTRAINT [DF__T_RuleAud__CADIS__24AD1002] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                   INT            NOT NULL,
    [CADIS_ROW_ID]                      INT            NOT NULL,
    [RuleAuditTrail_CADIS_ROW_ID]       INT            NULL,
    [RuleAuditTrail_Version]            NVARCHAR (100) NULL,
    [RuleAuditTrail_Date]               NVARCHAR (100) NULL,
    [RuleAuditTrail_xmlns]              NVARCHAR (100) NULL,
    [RuleAuditTrail_xmlns:xsi]          NVARCHAR (100) NULL,
    [RuleAuditTrail_xsi:schemaLocation] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__25A1343B] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__26955874] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__27897CAD] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT            CONSTRAINT [DF__T_RuleAud__CADIS__287DA0E6] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

