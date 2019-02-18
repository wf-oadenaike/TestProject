CREATE TABLE [Core].[SystemUsernames] (
    [PersonId]       SMALLINT      NOT NULL,
    [SourceSystemId] SMALLINT      NOT NULL,
    [Username]       VARCHAR (512) NOT NULL,
    CONSTRAINT [XPKSystemUsernames] PRIMARY KEY CLUSTERED ([PersonId] ASC, [SourceSystemId] ASC),
    CONSTRAINT [SystemUsernamesPersonId] FOREIGN KEY ([PersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [SystemUsernamesSourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [Audit].[SourceSystems] ([SourceSystemId]),
    CONSTRAINT [IDX_SU_Username] UNIQUE NONCLUSTERED ([PersonId] ASC, [SourceSystemId] ASC, [Username] ASC)
);

