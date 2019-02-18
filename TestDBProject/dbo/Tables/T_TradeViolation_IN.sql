CREATE TABLE [dbo].[T_TradeViolation_IN] (
    [CADIS_BATCH_ID]                    INT            NOT NULL,
    [CADIS_MSG_ID]                      INT            CONSTRAINT [DF__T_TradeVi__CADIS__7978993A] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                   INT            NOT NULL,
    [CADIS_ROW_ID]                      INT            NOT NULL,
    [TradeViolation_CADIS_ROW_ID]       INT            NULL,
    [TradeViolation_Version]            NVARCHAR (100) NULL,
    [TradeViolation_Date]               NVARCHAR (100) NULL,
    [TradeViolation_xmlns]              NVARCHAR (100) NULL,
    [TradeViolation_xmlns:xsi]          NVARCHAR (100) NULL,
    [TradeViolation_xsi:schemaLocation] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__7A6CBD73] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME       CONSTRAINT [DF__T_TradeVi__CADIS__7B60E1AC] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50)  CONSTRAINT [DF__T_TradeVi__CADIS__7C5505E5] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT            CONSTRAINT [DF__T_TradeVi__CADIS__7D492A1E] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_TradeViolation_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

