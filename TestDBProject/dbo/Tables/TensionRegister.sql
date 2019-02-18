CREATE TABLE [dbo].[TensionRegister] (
    [TensionId]              INT              IDENTITY (1, 1) NOT NULL,
    [CircleId]               SMALLINT         NOT NULL,
    [TensionSummary]         NVARCHAR (MAX)   NOT NULL,
    [TensionDescription]     NVARCHAR (MAX)   NOT NULL,
    [TensionResolution]      VARCHAR (MAX)    NULL,
    [ResolutionDate]         DATETIME         NULL,
    [RaisedByPersonId]       SMALLINT         NOT NULL,
    [JIRAKey]                NVARCHAR (50)    NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [SlackChannel]           NVARCHAR (21)    NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    PRIMARY KEY CLUSTERED ([TensionId] ASC) WITH (FILLFACTOR = 80),
    FOREIGN KEY ([CircleId]) REFERENCES [dbo].[NewOrgStructureCircles] ([CircleId])
);

