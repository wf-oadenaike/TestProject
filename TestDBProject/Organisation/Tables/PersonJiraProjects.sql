CREATE TABLE [Organisation].[PersonJiraProjects] (
    [PersonId]         SMALLINT     NOT NULL,
    [ProjectKey]       VARCHAR (31) NOT NULL,
    [PreferredProject] BIT          NULL,
    [CreatedDate]      DATETIME     CONSTRAINT [DF_PJP_CD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKPersonJiraProjects] PRIMARY KEY CLUSTERED ([PersonId] ASC, [ProjectKey] ASC),
    CONSTRAINT [DepartmentalJiraProjectsPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

