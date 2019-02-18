CREATE TABLE [Scheduler].[WorkflowLaunchList] (
    [WorkflowLaunchId] INT              IDENTITY (1, 1) NOT NULL,
    [FlowId]           UNIQUEIDENTIFIER NOT NULL,
    [LaunchDate]       DATE             NOT NULL,
    [LaunchRef]        VARCHAR (255)    NULL,
    [IsActive]         BIT              CONSTRAINT [DF_WLL_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]         UNIQUEIDENTIFIER NULL,
    [CreatedDate]      DATETIME         CONSTRAINT [DF_WLL_CD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKWorkflowLaunchList] PRIMARY KEY CLUSTERED ([WorkflowLaunchId] ASC),
    CONSTRAINT [WorkflowLaunchListFlowId] FOREIGN KEY ([FlowId]) REFERENCES [Scheduler].[Workflows] ([FlowId])
);

