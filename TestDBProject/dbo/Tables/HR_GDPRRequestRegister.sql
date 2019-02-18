CREATE TABLE [dbo].[HR_GDPRRequestRegister] (
    [GDPRRequestID]          INT              IDENTITY (1, 1) NOT NULL,
    [SubmittedByPersonID]    SMALLINT         NOT NULL,
    [RelatedPersonName]      VARCHAR (50)     NOT NULL,
    [DateCreated]            DATETIME         NOT NULL,
    [NextReviewDate]         DATETIME         NULL,
    [Summary]                VARCHAR (50)     NOT NULL,
    [Description]            VARCHAR (2000)   NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKGDPRRequestRegister] PRIMARY KEY CLUSTERED ([GDPRRequestID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [GDPRsubmittedbypersonid] FOREIGN KEY ([SubmittedByPersonID]) REFERENCES [Core].[Persons] ([PersonId])
);

