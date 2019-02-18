CREATE TABLE [Access.ManyWho].[EventBusinessReporting] (
    [EventId]          INT              IDENTITY (1, 1) NOT NULL,
    [EventType]        NVARCHAR (50)    NOT NULL,
    [EventDescription] NVARCHAR (MAX)   NULL,
    [EventTime]        DATETIME         NOT NULL,
    [StateId]          UNIQUEIDENTIFIER NOT NULL,
    [ElementId]        UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER NULL,
    [Created]          DATETIME         NOT NULL
);

