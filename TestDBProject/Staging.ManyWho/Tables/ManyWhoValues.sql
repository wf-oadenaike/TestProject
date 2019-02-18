CREATE TABLE [Staging.ManyWho].[ManyWhoValues] (
    [StateId]     UNIQUEIDENTIFIER NULL,
    [ElementId]   UNIQUEIDENTIFIER NULL,
    [Key]         VARCHAR (256)    NULL,
    [Value]       NVARCHAR (MAX)   NULL,
    [CreatedDate] DATETIME         CONSTRAINT [DF_MWV_CD] DEFAULT (getdate()) NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_ManyWhoValues__CreatedDate]
    ON [Staging.ManyWho].[ManyWhoValues]([CreatedDate] DESC);

