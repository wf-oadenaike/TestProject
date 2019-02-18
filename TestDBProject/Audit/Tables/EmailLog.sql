CREATE TABLE [Audit].[EmailLog] (
    [Id]          INT      IDENTITY (1, 1) NOT NULL,
    [ProcessId]   INT      NOT NULL,
    [EmailSent]   BIT      CONSTRAINT [df_el_es] DEFAULT ((0)) NOT NULL,
    [CreatedDate] DATETIME CONSTRAINT [df_el_dr] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKEmailLog] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [EmailLogProcessId] FOREIGN KEY ([ProcessId]) REFERENCES [Audit].[Processes] ([Id])
);

