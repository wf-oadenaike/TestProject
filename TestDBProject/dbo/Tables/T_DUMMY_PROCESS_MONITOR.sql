﻿CREATE TABLE [dbo].[T_DUMMY_PROCESS_MONITOR] (
    [SOURCE]                 NVARCHAR (30)   NOT NULL,
    [DESCRIPTION]            NVARCHAR (50)   NOT NULL,
    [DIRECTION]              NVARCHAR (3)    NOT NULL,
    [RUN_DATE]               DATETIME        NOT NULL,
    [FILE_NAME]              NVARCHAR (500)  NULL,
    [ENTITY]                 NVARCHAR (50)   NULL,
    [SOURCE_DATE]            DATETIME        NULL,
    [ROW_COUNT]              INT             NULL,
    [PREVIOUS_ROW_COUNT]     INT             NULL,
    [TOLERANCE]              INT             NULL,
    [VARIANCE]               DECIMAL (18, 2) NULL,
    [STATUS]                 NVARCHAR (30)   NULL,
    [PROCESSED]              BIT             NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF__T_DUMMY_P__CADIS__22322CB8] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF__T_DUMMY_P__CADIS__232650F1] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF__T_DUMMY_P__CADIS__241A752A] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]  INT             CONSTRAINT [DF__T_DUMMY_P__CADIS__250E9963] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_DUMMY___4CAE08F35F03F572] PRIMARY KEY CLUSTERED ([SOURCE] ASC, [DESCRIPTION] ASC, [DIRECTION] ASC, [RUN_DATE] ASC) WITH (FILLFACTOR = 90)
);

