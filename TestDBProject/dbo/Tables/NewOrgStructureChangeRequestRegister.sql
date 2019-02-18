CREATE TABLE [dbo].[NewOrgStructureChangeRequestRegister] (
    [RequestID]              INT              IDENTITY (1, 1) NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NULL,
    [StatusID]               INT              NOT NULL,
    [EntityID]               INT              NOT NULL,
    [EntityName]             NVARCHAR (MAX)   NOT NULL,
    [JiraIssueKey]           VARCHAR (50)     NULL,
    [Reason]                 VARCHAR (MAX)    NULL,
    [ChangeTypeID]           INT              NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [NewOrgStructureChangeRequestRegister_PK] PRIMARY KEY CLUSTERED ([RequestID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [ChangeTypeID] FOREIGN KEY ([ChangeTypeID]) REFERENCES [dbo].[NewOrgStructureChangeType] ([ChangeTypeId]),
    CONSTRAINT [StatusID] FOREIGN KEY ([StatusID]) REFERENCES [Core].[FlowStatus] ([FlowStatusId]),
    CONSTRAINT [SubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

