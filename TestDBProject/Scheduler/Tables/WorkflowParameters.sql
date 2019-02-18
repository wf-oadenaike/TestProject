CREATE TABLE [Scheduler].[WorkflowParameters] (
    [Id]               INT              IDENTITY (1, 1) NOT NULL,
    [WorkflowLaunchId] INT              NOT NULL,
    [Key]              VARCHAR (255)    NOT NULL,
    [Value]            VARCHAR (255)    NOT NULL,
    [ContentType]      VARCHAR (15)     NOT NULL,
    [JoinGUID]         UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PKWorkflowParameters] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [WorkflowParametersWorkflowLaunchId] FOREIGN KEY ([WorkflowLaunchId]) REFERENCES [Scheduler].[WorkflowLaunchList] ([WorkflowLaunchId])
);

