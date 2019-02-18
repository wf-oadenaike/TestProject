CREATE TABLE [Organisation].[HuddleControlLogRelationship] (
    [HuddleControlLogRelationshipId] INT              IDENTITY (1, 1) NOT NULL,
    [HuddleEventId]                  INT              NOT NULL,
    [ControlLogRegisterId]           INT              NOT NULL,
    [IsActive]                       BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]          DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]           DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]         NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKHuddleControlLogRelationship] PRIMARY KEY CLUSTERED ([HuddleControlLogRelationshipId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [HuddleControlLogRelationshipControlLogRegisterId] FOREIGN KEY ([ControlLogRegisterId]) REFERENCES [Audit].[ControlLogRegister] ([ControlLogRegisterId]),
    CONSTRAINT [HuddleControlLogRelationshipHuddleEventId] FOREIGN KEY ([HuddleEventId]) REFERENCES [Organisation].[HuddleEvents] ([EventId])
);

