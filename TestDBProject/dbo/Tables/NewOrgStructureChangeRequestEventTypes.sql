﻿CREATE TABLE [dbo].[NewOrgStructureChangeRequestEventTypes] (
    [EventTypeID]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EventType]              VARCHAR (50)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKNewOrgStructureChangeRequestEventTypes] PRIMARY KEY CLUSTERED ([EventTypeID] ASC) WITH (FILLFACTOR = 80)
);

