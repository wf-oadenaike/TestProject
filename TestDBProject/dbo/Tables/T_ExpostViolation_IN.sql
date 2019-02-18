CREATE TABLE [dbo].[T_ExpostViolation_IN] (
    [CADIS_BATCH_ID]                     INT            NOT NULL,
    [CADIS_MSG_ID]                       INT            CONSTRAINT [DF__T_ExpostV__CADIS__0771B2D6] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                    INT            NOT NULL,
    [CADIS_ROW_ID]                       INT            NOT NULL,
    [ExpostViolation_CADIS_ROW_ID]       INT            NULL,
    [ExpostViolation_Version]            NVARCHAR (100) NULL,
    [ExpostViolation_Date]               NVARCHAR (100) NULL,
    [ExpostViolation_xmlns]              NVARCHAR (100) NULL,
    [ExpostViolation_xmlns:xsi]          NVARCHAR (100) NULL,
    [ExpostViolation_xsi:schemaLocation] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]              DATETIME       CONSTRAINT [DF__T_ExpostV__CADIS__0865D70F] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]               DATETIME       CONSTRAINT [DF__T_ExpostV__CADIS__0959FB48] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]             NVARCHAR (50)  CONSTRAINT [DF__T_ExpostV__CADIS__0A4E1F81] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]              INT            CONSTRAINT [DF__T_ExpostV__CADIS__0B4243BA] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_ExpostViolation_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

