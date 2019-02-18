CREATE TABLE [dbo].[T_TradeViolation_Violation_IN] (
    [CADIS_BATCH_ID]               INT            NOT NULL,
    [CADIS_MSG_ID]                 INT            CONSTRAINT [DF__T_TradeVi__CADIS__72CB9BAB] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]              INT            NOT NULL,
    [CADIS_ROW_ID]                 INT            NOT NULL,
    [Violation_CADIS_ROW_ID]       INT            NULL,
    [Violation_ViolDateTime]       NVARCHAR (100) NULL,
    [Violation_ViolGrpID]          NVARCHAR (100) NULL,
    [Violation_ViolID]             NVARCHAR (100) NULL,
    [Violation_ViolSeverity]       NVARCHAR (100) NULL,
    [Violation_ViolStatus]         NVARCHAR (100) NULL,
    [Violation_ViolType]           NVARCHAR (100) NULL,
    [Violation_ViolPriority]       NVARCHAR (100) NULL,
    [Violation_ViolationTriggered] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]        DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__73BFBFE4] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]         DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__74B3E41D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]       NVARCHAR (50)  CONSTRAINT [DF__T_TradeVi__CADIS__75A80856] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]        INT            CONSTRAINT [DF__T_TradeVi__CADIS__769C2C8F] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_Violation_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

