CREATE TABLE [dbo].[CircleProcesses] (
    [Id]                     INT           IDENTITY (1, 1) NOT NULL,
    [CircleId]               SMALLINT      NULL,
    [Name]                   VARCHAR (255) NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_OrganisationCircles] FOREIGN KEY ([CircleId]) REFERENCES [Organisation].[Circles] ([CircleId])
);

