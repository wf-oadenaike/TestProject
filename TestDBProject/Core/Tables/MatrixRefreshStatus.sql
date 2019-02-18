CREATE TABLE [Core].[MatrixRefreshStatus] (
    [StepName]    VARCHAR (50) NULL,
    [StepStatus]  VARCHAR (50) NULL,
    [CompletedAt] DATETIME     DEFAULT (getdate()) NULL
);

