﻿CREATE TABLE [dbo].[T_PROCESS_NOTIFICATIONS] (
    [RUNID]                     INT           NOT NULL,
    [PROCESS_NAME]              VARCHAR (250) NOT NULL,
    [PROCESS_TYPE]              VARCHAR (50)  NOT NULL,
    [NOTIFICATION_SENT]         DATETIME      NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF__T_PROCESS__CADIS__0774E032] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF__T_PROCESS__CADIS__0869046B] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF__T_PROCESS__CADIS__095D28A4] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF__T_PROCESS__CADIS__0A514CDD] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF__T_PROCESS__CADIS__0B457116] DEFAULT (getdate()) NULL,
    [RUNSTART]                  DATETIME      NULL,
    [RUNEND]                    DATETIME      NULL,
    [RUNSUCCESSFUL]             BIT           NULL,
    CONSTRAINT [PK__T_PROCES__D51EB6AB6F7299AF] PRIMARY KEY CLUSTERED ([RUNID] ASC, [PROCESS_NAME] ASC, [PROCESS_TYPE] ASC) WITH (FILLFACTOR = 90)
);

