CREATE TABLE [Access.ManyWho].[DimBusinessReportingFlows] (
    [FlowId]   UNIQUEIDENTIFIER NOT NULL,
    [FlowName] NVARCHAR (255)   NOT NULL,
    [Created]  DATETIME         NOT NULL,
    CONSTRAINT [PKBusinessReportingFlows] PRIMARY KEY CLUSTERED ([FlowId] ASC)
);

