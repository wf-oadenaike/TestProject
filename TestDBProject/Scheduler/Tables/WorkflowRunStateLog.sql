CREATE TABLE [Scheduler].[WorkflowRunStateLog] (
    [WorkflowRunStateLogId] INT           IDENTITY (1, 1) NOT NULL,
    [WorkflowLaunchId]      INT           NOT NULL,
    [StateId]               INT           NOT NULL,
    [Note]                  VARCHAR (511) NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_QRSL_CD] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([WorkflowRunStateLogId] ASC),
    CONSTRAINT [WorkflowRunStateLogStateId] FOREIGN KEY ([StateId]) REFERENCES [Scheduler].[WorkflowRunStateTypes] ([StateId]),
    CONSTRAINT [WorkflowRunStateLogWorkflowLaunchId] FOREIGN KEY ([WorkflowLaunchId]) REFERENCES [Scheduler].[WorkflowLaunchList] ([WorkflowLaunchId])
);

