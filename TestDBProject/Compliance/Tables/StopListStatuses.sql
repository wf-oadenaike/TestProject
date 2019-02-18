CREATE TABLE [Compliance].[StopListStatuses] (
    [StopListStatusId]   SMALLINT      IDENTITY (1, 1) NOT NULL,
    [StopListStatusName] VARCHAR (128) NOT NULL,
    PRIMARY KEY CLUSTERED ([StopListStatusId] ASC) WITH (FILLFACTOR = 80)
);

