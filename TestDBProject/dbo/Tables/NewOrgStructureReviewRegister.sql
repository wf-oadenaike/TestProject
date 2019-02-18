CREATE TABLE [dbo].[NewOrgStructureReviewRegister] (
    [ReviewID]               INT              IDENTITY (1, 1) NOT NULL,
    [StatusID]               INT              NOT NULL,
    [RequestID]              INT              NOT NULL,
    [ReviewTypeID]           INT              NOT NULL,
    [Details]                VARCHAR (MAX)    NULL,
    [SubmittedDate]          DATETIME         NOT NULL,
    [ReviewerPersonID]       SMALLINT         NULL,
    [JiraIssueKey]           NVARCHAR (50)    NULL,
    [IsActive]               BIT              DEFAULT ((1)) NOT NULL,
    [JoinGUID]               UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME         DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)    DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKNewOrgStructureReviewRegister] PRIMARY KEY CLUSTERED ([ReviewID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [NOReviewerPersonID] FOREIGN KEY ([ReviewerPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [NOSRequestID] FOREIGN KEY ([RequestID]) REFERENCES [dbo].[NewOrgStructureChangeRequestRegister] ([RequestID]),
    CONSTRAINT [NSRequestID] FOREIGN KEY ([ReviewTypeID]) REFERENCES [dbo].[NewOrgStructureReviewType] ([ReviewTypeId]),
    CONSTRAINT [SCStatusID] FOREIGN KEY ([StatusID]) REFERENCES [Core].[FlowStatus] ([FlowStatusId])
);

