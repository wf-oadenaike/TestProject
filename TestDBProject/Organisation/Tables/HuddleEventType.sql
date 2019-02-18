CREATE TABLE [Organisation].[HuddleEventType] (
    [EventTypeId]            SMALLINT      IDENTITY (1, 1) NOT NULL,
    [EventTypeName]          NVARCHAR (50) NOT NULL,
    [EventTypeCode]          NVARCHAR (50) NOT NULL,
    [EventTypeOwnerId]       SMALLINT      NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PK_HuddleEventType] PRIMARY KEY CLUSTERED ([EventTypeId] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([EventTypeOwnerId]) REFERENCES [Core].[Persons] ([PersonId])
);

