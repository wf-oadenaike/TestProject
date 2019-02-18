CREATE TABLE [Access.ManyWho].[FactBusinessReporting] (
    [Id]          INT              IDENTITY (1, 1) NOT NULL,
    [UserId]      UNIQUEIDENTIFIER NULL,
    [FlowId]      UNIQUEIDENTIFIER NULL,
    [StateId]     UNIQUEIDENTIFIER NULL,
    [ElementId]   UNIQUEIDENTIFIER NULL,
    [CalendarId]  INT              NULL,
    [Time]        TIME (3)         NULL,
    [Key]         VARCHAR (256)    NULL,
    [Value]       NVARCHAR (MAX)   NULL,
    [IsCompleted] BIT              NULL,
    [Created]     DATETIME         NOT NULL,
    CONSTRAINT [PKBusinessReporting] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [BusinessReportingCalendarId] FOREIGN KEY ([CalendarId]) REFERENCES [Core].[Calendar] ([CalendarId]),
    CONSTRAINT [BusinessReportingElementId] FOREIGN KEY ([ElementId]) REFERENCES [Access.ManyWho].[DimBusinessReportingElements] ([ElementId]),
    CONSTRAINT [BusinessReportingFlowId] FOREIGN KEY ([FlowId]) REFERENCES [Access.ManyWho].[DimBusinessReportingFlows] ([FlowId])
);

