CREATE TABLE [dbo].[T_RecentDeaggregatedSlackNarrative] (
    [BaseOrderID] INT            NULL,
    [OrderID]     INT            NULL,
    [EventDate]   DATETIME       NULL,
    [PostedBy]    VARCHAR (128)  NULL,
    [Narrative]   NVARCHAR (MAX) NULL,
    [EventType]   VARCHAR (20)   NULL
);

