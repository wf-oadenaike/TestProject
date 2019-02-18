CREATE TABLE [dbo].[T_EndOfDayViolation_IN] (
    [CADIS_BATCH_ID]                       INT            NOT NULL,
    [CADIS_MSG_ID]                         INT            CONSTRAINT [DF__T_EndOfDa__CADIS__7A4CC1E2] DEFAULT ((1)) NOT NULL,
    [CADIS_PARENT_ID]                      INT            NOT NULL,
    [CADIS_ROW_ID]                         INT            NOT NULL,
    [EndOfDayViolation_CADIS_ROW_ID]       INT            NULL,
    [EndOfDayViolation_Version]            NVARCHAR (100) NULL,
    [EndOfDayViolation_Date]               NVARCHAR (100) NULL,
    [EndOfDayViolation_xmlns]              NVARCHAR (100) NULL,
    [EndOfDayViolation_xmlns:xsi]          NVARCHAR (100) NULL,
    [EndOfDayViolation_xsi:schemaLocation] NVARCHAR (100) NULL,
    [CADIS_SYSTEM_INSERTED]                DATETIME       CONSTRAINT [DF__T_EndOfDa__CADIS__7B40E61B] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                 DATETIME       CONSTRAINT [DF__T_EndOfDa__CADIS__7C350A54] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]               NVARCHAR (50)  CONSTRAINT [DF__T_EndOfDa__CADIS__7D292E8D] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                INT            CONSTRAINT [DF__T_EndOfDa__CADIS__7E1D52C6] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_T_EndOfDayViolation_IN] PRIMARY KEY CLUSTERED ([CADIS_BATCH_ID] ASC, [CADIS_MSG_ID] ASC, [CADIS_PARENT_ID] ASC, [CADIS_ROW_ID] ASC) WITH (FILLFACTOR = 90)
);

