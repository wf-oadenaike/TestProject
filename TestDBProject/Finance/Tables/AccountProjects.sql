CREATE TABLE [Finance].[AccountProjects] (
    [ProjectCode] VARCHAR (31)  NOT NULL,
    [ProjectName] VARCHAR (255) NOT NULL,
    [ControlId]   BIGINT        NOT NULL,
    PRIMARY KEY CLUSTERED ([ProjectCode] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ndx_projectName]
    ON [Finance].[AccountProjects]([ProjectName] ASC) WITH (FILLFACTOR = 80);

