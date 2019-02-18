CREATE TABLE [dbo].[T_RuleAuditTrail_Rule_Revision_Attributes_Attribute_attributeValAfter_value_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_RuleAud__CADIS__5A14FC7A] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [value_CADIS_ROW_ID]     INT            NULL,
    [value_value_InnerText]  NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__5B0920B3] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_RuleAud__CADIS__5BFD44EC] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_RuleAud__CADIS__5CF16925] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_RuleAud__CADIS__5DE58D5E] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_RuleAuditTrail_Rule_Revision_Attributes_Attribute_attributeValAfter_value_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

