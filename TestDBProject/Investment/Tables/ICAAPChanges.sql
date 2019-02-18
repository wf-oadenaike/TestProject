CREATE TABLE [Investment].[ICAAPChanges] (
    [ICAAPChangeId]                   INT              IDENTITY (1, 1) NOT NULL,
    [ICAAPRegisterId]                 INT              NOT NULL,
    [ChangeAmount]                    DECIMAL (19, 2)  NULL,
    [PercentageChange]                DECIMAL (19, 2)  NULL,
    [ICAAPChangeDueTo]                VARCHAR (MAX)    NULL,
    [ICAAPAmendmentDate]              DATETIME         NULL,
    [ICAAPChangeStatus]               VARCHAR (50)     NOT NULL,
    [AmendedByPersonId]               SMALLINT         NOT NULL,
    [DocumentationFolderLink]         VARCHAR (2000)   NULL,
    [JoinGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [ICAAPChangeCreationDatetime]     DATETIME         CONSTRAINT [DF_IC_ICCDT] DEFAULT (getdate()) NOT NULL,
    [ICAAPChangeLastModifiedDatetime] DATETIME         CONSTRAINT [DF_IC_ICLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKICAAPChanges] PRIMARY KEY CLUSTERED ([ICAAPChangeId] ASC),
    CONSTRAINT [ICAAPChangesAmendedByPersonId] FOREIGN KEY ([AmendedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ICAAPChangesICAAPRegisterId] FOREIGN KEY ([ICAAPRegisterId]) REFERENCES [Investment].[ICAAPRegister] ([ICAAPRegisterId])
);

