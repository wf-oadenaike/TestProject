CREATE TABLE [Scheduler].[Workflows] (
    [FlowId]   UNIQUEIDENTIFIER NOT NULL,
    [FlowName] VARCHAR (255)    NOT NULL,
    [TenantId] UNIQUEIDENTIFIER NOT NULL,
    [Player]   VARCHAR (255)    NOT NULL,
    PRIMARY KEY CLUSTERED ([FlowId] ASC)
);

