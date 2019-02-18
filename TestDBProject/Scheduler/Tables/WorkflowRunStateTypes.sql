CREATE TABLE [Scheduler].[WorkflowRunStateTypes] (
    [StateId] INT           NOT NULL,
    [State]   VARCHAR (127) NOT NULL,
    PRIMARY KEY CLUSTERED ([StateId] ASC)
);

