CREATE TABLE [dbo].[T_TradeViolation_Violation_Scope_IN] (
    [CADIS_BATCH_ID]         INT            NOT NULL,
    [CADIS_MSG_ID]           INT            CONSTRAINT [DF__T_TradeVi__CADIS__4410ACC2] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]        INT            NOT NULL,
    [CADIS_ROW_ID]           INT            NOT NULL,
    [Scope_CADIS_ROW_ID]     INT            NULL,
    [Scope_ScopeCode]        NVARCHAR (100) NULL,
    [Scope_ScopeName]        NVARCHAR (100) NULL,
    [Scope_ScopeNum]         NVARCHAR (100) NULL,
    [Scope_ScopeType]        NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__4504D0FB] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__45F8F534] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)  CONSTRAINT [DF__T_TradeVi__CADIS__46ED196D] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT            CONSTRAINT [DF__T_TradeVi__CADIS__47E13DA6] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_Scope_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

