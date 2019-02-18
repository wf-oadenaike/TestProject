CREATE TABLE [Compliance].[StopListRegister] (
    [StopListId]             INT              IDENTITY (1, 1) NOT NULL,
    [StoppedCompanyName]     NVARCHAR (128)   NOT NULL,
    [Ticker]                 VARCHAR (50)     NULL,
    [StopListStatusId]       INT              NOT NULL,
    [StoppedDate]            DATETIME         NULL,
    [CleansedDate]           DATETIME         NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    NULL,
    CONSTRAINT [StopListRegisterStopListId] PRIMARY KEY CLUSTERED ([StopListId] ASC) WITH (FILLFACTOR = 80)
);

