﻿CREATE TABLE [dbo].[T_BPS_PRICE_HISTORY_IN] (
    [FILE_NAME]              VARCHAR (50)    NULL,
    [RUN_DATE]               DATETIME        NULL,
    [ID_BB_UNIQUE]           VARCHAR (50)    NOT NULL,
    [PX_DATE]                DATETIME        NOT NULL,
    [PX_LAST]                DECIMAL (20, 6) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF__T_BPS_PRI__CADIS__2AA9D92D] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF__T_BPS_PRI__CADIS__2B9DFD66] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF__T_BPS_PRI__CADIS__2C92219F] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK__T_BPS_PR__B862D7FEB432BA16] PRIMARY KEY CLUSTERED ([ID_BB_UNIQUE] ASC, [PX_DATE] ASC) WITH (FILLFACTOR = 90)
);
