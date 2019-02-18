CREATE TABLE [Sales].[FundManagerSignOff] (
    [FundManagerSignOffId]                   INT              IDENTITY (1, 1) NOT NULL,
    [SubmittedByPersonId]                    SMALLINT         CONSTRAINT [DF_FMS_FMSSP] DEFAULT ((-1)) NOT NULL,
    [SubmittedDate]                          DATETIME         CONSTRAINT [DF_FMS_FMSSD] DEFAULT (getdate()) NOT NULL,
    [ReviewedByPersonId]                     SMALLINT         NULL,
    [ReviewDate]                             DATE             NULL,
    [Status]                                 VARCHAR (50)     NULL,
    [MandateId]                              INT              NULL,
    [ValuationDate]                          DATE             NOT NULL,
    [JiraIssueKey]                           VARCHAR (32)     NULL,
    [Notes]                                  VARCHAR (MAX)    NULL,
    [BoxFolderId]                            VARCHAR (25)     NULL,
    [DocumentationFolderLink]                VARCHAR (2000)   NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NOT NULL,
    [FundManagerSignOffCreationDatetime]     DATETIME         CONSTRAINT [DF_FMS_FMSCDT] DEFAULT (getdate()) NOT NULL,
    [FundManagerSignOffLastModifiedDatetime] DATETIME         CONSTRAINT [DF_FMS_FMSLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKFundManagerSignOffEvents] PRIMARY KEY CLUSTERED ([FundManagerSignOffId] ASC),
    CONSTRAINT [FundManagerSignOffMandateId] FOREIGN KEY ([MandateId]) REFERENCES [Investment].[Mandates] ([MandateId]),
    CONSTRAINT [FundManagerSignOffReviewedByPersonId] FOREIGN KEY ([ReviewedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [FundManagerSignOffSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

