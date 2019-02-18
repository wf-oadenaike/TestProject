CREATE TABLE [dbo].[Compliance_WatchlistReasonType] (
    [ReasonTypeId]           SMALLINT         IDENTITY (1, 1) NOT NULL,
    [ReasonName]             VARCHAR (100)    NOT NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKWatchlistReasonType] PRIMARY KEY CLUSTERED ([ReasonTypeId] ASC) WITH (FILLFACTOR = 80)
);

