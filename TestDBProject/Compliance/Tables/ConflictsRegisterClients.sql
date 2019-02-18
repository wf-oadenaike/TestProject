CREATE TABLE [Compliance].[ConflictsRegisterClients] (
    [ConflictsRegisterClientId] INT            IDENTITY (1, 1) NOT NULL,
    [ConflictId]                INT            NOT NULL,
    [ClientSalesforceId]        CHAR (18)      NOT NULL,
    [ClientName]                NVARCHAR (511) NOT NULL,
    [CreatedByPersonId]         SMALLINT       NOT NULL,
    [CreationDate]              DATETIME       CONSTRAINT [DF_CRC_CDT] DEFAULT (getdate()) NOT NULL,
    [IsActive]                  BIT            NULL,
    CONSTRAINT [XPKConflictsRegisterClients] PRIMARY KEY CLUSTERED ([ConflictsRegisterClientId] ASC),
    CONSTRAINT [ConflictsRegisterClientsConflictId] FOREIGN KEY ([ConflictId]) REFERENCES [Compliance].[ConflictsRegisterPotential] ([ConflictId]),
    CONSTRAINT [ConflictsRegisterClientsCreatedByPersionId] FOREIGN KEY ([CreatedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

