CREATE TABLE [Organisation].[HuddleRegisterEventTypes] (
    [EventTypeId]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EventTypeName]          VARCHAR (50)  NOT NULL,
    [IsActive]               BIT           DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKHuddleRegisterEventTypes] PRIMARY KEY CLUSTERED ([EventTypeId] ASC) WITH (FILLFACTOR = 80)
);

