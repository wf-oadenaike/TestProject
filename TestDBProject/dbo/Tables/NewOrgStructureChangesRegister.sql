CREATE TABLE [dbo].[NewOrgStructureChangesRegister] (
    [ChangeID]               INT              IDENTITY (1, 1) NOT NULL,
    [RequestID]              INT              NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NULL,
    [AccountabilityID]       INT              NULL,
    [CurrentValue]           VARCHAR (MAX)    NULL,
    [ProposedValue]          VARCHAR (MAX)    NULL,
    [ChangeTypeID]           INT              NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [NewOrgStructureChangesRegister_PK] PRIMARY KEY CLUSTERED ([ChangeID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [SCChangeTypeID] FOREIGN KEY ([ChangeTypeID]) REFERENCES [dbo].[NewOrgStructureChangeType] ([ChangeTypeId]),
    CONSTRAINT [SCRequestID] FOREIGN KEY ([RequestID]) REFERENCES [dbo].[NewOrgStructureChangeRequestRegister] ([RequestID]),
    CONSTRAINT [SCSubmittedByPersonID] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

