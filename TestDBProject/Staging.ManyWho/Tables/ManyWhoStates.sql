CREATE TABLE [Staging.ManyWho].[ManyWhoStates] (
    [ElementId]    UNIQUEIDENTIFIER NULL,
    [ElementName]  NVARCHAR (256)   NULL,
    [StateId]      UNIQUEIDENTIFIER NULL,
    [TenantId]     UNIQUEIDENTIFIER NULL,
    [TenantName]   NVARCHAR (256)   NULL,
    [FlowId]       UNIQUEIDENTIFIER NULL,
    [FlowName]     NVARCHAR (256)   NULL,
    [VersionId]    UNIQUEIDENTIFIER NULL,
    [IsCompleted]  BIT              NULL,
    [UserId]       UNIQUEIDENTIFIER NULL,
    [Email]        VARCHAR (255)    NULL,
    [TimestampUTC] DATETIME         NULL,
    [CreatedDate]  DATETIME         CONSTRAINT [DF_MWS_CD] DEFAULT (getdate()) NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_ManyWhoStates__CreatedDate]
    ON [Staging.ManyWho].[ManyWhoStates]([CreatedDate] DESC);

