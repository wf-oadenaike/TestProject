CREATE TABLE [Organisation].[CompanyKeyBusinessDateEvents] (
    [CompanyKeyBusinessDateEventId]                   INT              IDENTITY (1, 1) NOT NULL,
    [CompanyKeyBusinessDateId]                        INT              NOT NULL,
    [FinancialYear]                                   VARCHAR (20)     NULL,
    [SubmittedByPersonId]                             SMALLINT         CONSTRAINT [DF_CKBDE_CKBDESP] DEFAULT ((-1)) NOT NULL,
    [EventDate]                                       DATETIME         NULL,
    [DueDate]                                         DATETIME         NULL,
    [ClosedDate]                                      DATETIME         NULL,
    [DocumentationFolderLink]                         VARCHAR (2000)   NULL,
    [JoinGUID]                                        UNIQUEIDENTIFIER NOT NULL,
    [CompanyKeyBusinessDateEventCreationDatetime]     DATETIME         CONSTRAINT [DF_CKBDE_CKBDECD] DEFAULT (getdate()) NOT NULL,
    [CompanyKeyBusinessDateEventLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CKBDE_CKBDELMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                           DATETIME         CONSTRAINT [DF_CKBDE_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                            DATETIME         CONSTRAINT [DF_CKBDE_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                          NVARCHAR (50)    CONSTRAINT [DF_CKBDE_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                           INT              CONSTRAINT [DF_CKBDE_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                          ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                       DATETIME         CONSTRAINT [DF_CKBDE_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKCompanyKeyBusinessDateEvents] PRIMARY KEY CLUSTERED ([CompanyKeyBusinessDateEventId] ASC),
    CONSTRAINT [CompanyKeyBusinessDateEventsCompanyKeyBusinessDateId] FOREIGN KEY ([CompanyKeyBusinessDateId]) REFERENCES [Organisation].[CompanyKeyBusinessDateRegister] ([CompanyKeyBusinessDateId]),
    CONSTRAINT [CompanyKeyBusinessDateEventsSubmittedByPersonId] FOREIGN KEY ([SubmittedByPersonId]) REFERENCES [Core].[Persons] ([PersonId])
);

