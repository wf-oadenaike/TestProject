CREATE TABLE [Compliance].[ConflictsRegister] (
    [ConflictRegisterIdBK]     INT              IDENTITY (1, 1) NOT NULL,
    [NotifyingPersonId]        SMALLINT         NOT NULL,
    [ConflictTitle]            VARCHAR (100)    NOT NULL,
    [ConflictSummary]          VARCHAR (2048)   NOT NULL,
    [ConflictClosed]           BIT              CONSTRAINT [DF_CONR_CC] DEFAULT ((0)) NULL,
    [ConflictInactive]         BIT              CONSTRAINT [DF_CONR_CI] DEFAULT ((0)) NULL,
    [DocumentationFolderLink]  VARCHAR (2000)   NULL,
    [WorkflowVersionGUID]      UNIQUEIDENTIFIER CONSTRAINT [DF_CONR_WVG] DEFAULT (newid()) NOT NULL,
    [JoinGUID]                 UNIQUEIDENTIFIER CONSTRAINT [DF_CONR_JG] DEFAULT (newid()) NOT NULL,
    [ConflictCreationDate]     DATETIME         CONSTRAINT [DF_CONR_CCD] DEFAULT (getdate()) NOT NULL,
    [ConflictLastModifiedDate] DATETIME         CONSTRAINT [DF_CONR_CLMD] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [XPKConflictsRegister] PRIMARY KEY CLUSTERED ([ConflictRegisterIdBK] ASC),
    CONSTRAINT [ConflictsRegisterNotifingPersonId] FOREIGN KEY ([NotifyingPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IXUConflictsRegisterJoinGUID]
    ON [Compliance].[ConflictsRegister]([JoinGUID] ASC);

