CREATE TABLE [Core].[Sectors] (
    [SectorId]       INT            IDENTITY (1, 1) NOT NULL,
    [Sector]         NVARCHAR (127) NOT NULL,
    [ParentSectorId] INT            NOT NULL,
    [CreatedDate]    DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([SectorId] ASC),
    CONSTRAINT [SectorsSectorId] FOREIGN KEY ([ParentSectorId]) REFERENCES [Core].[Sectors] ([SectorId])
);

