﻿CREATE TABLE [dbo].[T_PROCESS_MONITOR_SLA_STORE] (
    [STORE_DATE]              DATETIME      NOT NULL,
    [SOURCE]                  VARCHAR (30)  NOT NULL,
    [ENTITY]                  VARCHAR (50)  NOT NULL,
    [DESCRIPTION]             VARCHAR (50)  NOT NULL,
    [DIRECTION]               VARCHAR (3)   NOT NULL,
    [DATE]                    DATE          NULL,
    [EXPECTED_DELIVERY_TIME]  DATETIME      NULL,
    [ACTUAL_DELIVERY_TIME]    DATETIME      NULL,
    [DELIVERY_SLA_MET]        BIT           NULL,
    [EXPECTED_SLA_COMPLETION] DATETIME      NULL,
    [ACTUAL_SLA_COMPLETION]   DATETIME      NULL,
    [PROCESSING_SLA_MET]      BIT           NULL,
    [PROCESSING_TIME]         DATETIME      NULL,
    [DATA_CHANNEL_ID]         INT           NULL,
    [CADIS_SYSTEM_INSERTED]   DATETIME      CONSTRAINT [DF__T_PROCESS__CADIS__5D79E25C] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]    DATETIME      CONSTRAINT [DF__T_PROCESS__CADIS__5E6E0695] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]  NVARCHAR (50) CONSTRAINT [DF__T_PROCESS__CADIS__5F622ACE] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]   INT           CONSTRAINT [DF__T_PROCESS__CADIS__60564F07] DEFAULT ((1)) NULL,
    CONSTRAINT [PK__T_PROCES__A3622CAA63E120AB] PRIMARY KEY CLUSTERED ([STORE_DATE] DESC, [SOURCE] ASC, [ENTITY] ASC, [DESCRIPTION] ASC, [DIRECTION] ASC) WITH (FILLFACTOR = 90)
);

