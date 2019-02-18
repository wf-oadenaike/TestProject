CREATE TABLE [Audit].[SourceSystems] (
    [SourceSystemId]   SMALLINT     IDENTITY (1, 1) NOT NULL,
    [SourceSystemCode] VARCHAR (20) NOT NULL,
    [SourceSystemName] [sysname]    NOT NULL,
    CONSTRAINT [XPKSourceSystems] PRIMARY KEY CLUSTERED ([SourceSystemId] ASC)
);

