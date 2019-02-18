CREATE TABLE [Organisation].[Whistleblowing] (
    [WhistleblowingId]               INT              IDENTITY (1, 1) NOT NULL,
    [RaisedByPersonId]               SMALLINT         NULL,
    [RaisedDate]                     DATE             NULL,
    [ReviewedByPersonId]             SMALLINT         NULL,
    [ReviewedDate]                   DATE             NULL,
    [Summary]                        NVARCHAR (MAX)   NULL,
    [Comments]                       NVARCHAR (MAX)   NULL,
    [Status]                         VARCHAR (128)    NULL,
    [EmployeeNotifiedYesNo]          BIT              NULL,
    [AnonymousConcernYesNo]          BIT              NULL,
    [ConcernAgainstComplianceYesNo]  BIT              NULL,
    [DocumentationFolderLink]        VARCHAR (2000)   NULL,
    [JoinGUID]                       UNIQUEIDENTIFIER NOT NULL,
    [WhistleblowingCreationDate]     DATETIME         CONSTRAINT [DF_WB_RCDT] DEFAULT (getdate()) NOT NULL,
    [WhistleblowingLastModifiedDate] DATETIME         CONSTRAINT [DF_WB_RLMDT] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PKWhistleblowing] PRIMARY KEY CLUSTERED ([WhistleblowingId] ASC),
    CONSTRAINT [WhistleblowingRaisedByPersonId] FOREIGN KEY ([RaisedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [WhistleblowingReviewedByPersonId] FOREIGN KEY ([ReviewedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

