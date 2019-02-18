CREATE TABLE [dbo].[Compliance_WatchlistIdentifierType] (
    [IdentifierTypeId]       SMALLINT         IDENTITY (1, 1) NOT NULL,
    [IdentifierName]         VARCHAR (100)    NOT NULL,
    [IsActive]               BIT              NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([IdentifierTypeId] ASC) WITH (FILLFACTOR = 80)
);

