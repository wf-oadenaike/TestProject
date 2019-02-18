CREATE TABLE [dbo].[T_TradeViolation_Violation_ViolationNote_NoteDetails_IN] (
    [CADIS_BATCH_ID]           INT             NOT NULL,
    [CADIS_MSG_ID]             INT             CONSTRAINT [DF__T_TradeVi__CADIS__07FBC2BB] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]          INT             NOT NULL,
    [CADIS_ROW_ID]             INT             NOT NULL,
    [NoteDetails_CADIS_ROW_ID] INT             NULL,
    [NoteDetails_DateTime]     NVARCHAR (100)  NULL,
    [NoteDetails_Note]         NVARCHAR (1000) NULL,
    [NoteDetails_User]         NVARCHAR (100)  NULL,
    [CADIS_SYSTEM_INSERTED]    DATETIME        CONSTRAINT [DF__T_TradeVi__CADIS__08EFE6F4] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]     DATETIME        CONSTRAINT [DF__T_TradeVi__CADIS__09E40B2D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]   NVARCHAR (50)   CONSTRAINT [DF__T_TradeVi__CADIS__0AD82F66] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]    INT             CONSTRAINT [DF__T_TradeVi__CADIS__0BCC539F] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_ViolationNote_NoteDetails_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

