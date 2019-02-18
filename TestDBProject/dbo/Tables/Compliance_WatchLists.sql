CREATE TABLE [dbo].[Compliance_WatchLists] (
    [WatchlistId]            INT              IDENTITY (1, 1) NOT NULL,
    [WatchlistCode]          VARCHAR (6)      NULL,
    [WatchlistDescription]   VARCHAR (MAX)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [IsActive]               BIT              NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         CONSTRAINT [T_WL_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         CONSTRAINT [T_WL_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    CONSTRAINT [T_WL_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKWatchlists] PRIMARY KEY CLUSTERED ([WatchlistId] ASC) WITH (FILLFACTOR = 80)
);

