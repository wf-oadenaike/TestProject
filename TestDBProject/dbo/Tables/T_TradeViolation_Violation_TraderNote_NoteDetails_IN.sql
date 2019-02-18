CREATE TABLE [dbo].[T_TradeViolation_Violation_TraderNote_NoteDetails_IN] (
    [CADIS_BATCH_ID]           INT             NOT NULL,
    [CADIS_MSG_ID]             INT             CONSTRAINT [DF__T_TradeVi__CADIS__1555BDD9] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]          INT             NOT NULL,
    [CADIS_ROW_ID]             INT             NOT NULL,
    [NoteDetails_CADIS_ROW_ID] INT             NULL,
    [NoteDetails_DateTime]     NVARCHAR (100)  NULL,
    [NoteDetails_Note]         NVARCHAR (1000) NULL,
    [NoteDetails_User]         NVARCHAR (100)  NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME        CONSTRAINT [DF__T_TradeVi__CADIS__1649E212] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME        CONSTRAINT [DF__T_TradeVi__CADIS__173E064B] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50)   CONSTRAINT [DF__T_TradeVi__CADIS__18322A84] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]    INT             CONSTRAINT [DF__T_TradeVi__CADIS__19264EBD] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_TraderNote_NoteDetails_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

