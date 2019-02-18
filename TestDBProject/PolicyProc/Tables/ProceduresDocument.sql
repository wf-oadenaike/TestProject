CREATE TABLE [PolicyProc].[ProceduresDocument] (
    [ProcDocumentId]                         INT              IDENTITY (1, 1) NOT NULL,
    [DocumentName]                           VARCHAR (255)    NOT NULL,
    [Version]                                VARCHAR (20)     NULL,
    [Status]                                 VARCHAR (128)    NULL,
    [SummaryDescription]                     VARCHAR (MAX)    NULL,
    [ReviewFrequencyId]                      INT              CONSTRAINT [DF_PD_RF] DEFAULT ((1)) NOT NULL,
    [LastReviewDate]                         DATE             NULL,
    [NextReviewDate]                         DATE             NULL,
    [PolicyId]                               INT              NULL,
    [IsActive]                               BIT              CONSTRAINT [DF_PD_IA] DEFAULT ((1)) NULL,
    [ModifiedByPersonId]                     SMALLINT         NULL,
    [DocumentCategoryId]                     INT              NULL,
    [DocumentationFolderLink]                VARCHAR (2000)   NULL,
    [JoinGUID]                               UNIQUEIDENTIFIER NOT NULL,
    [ProceduresDocumentCreationDatetime]     DATETIME         CONSTRAINT [DF_PD_PDCDT] DEFAULT (getdate()) NOT NULL,
    [ProceduresDocumentLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PD_PDLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                  DATETIME         CONSTRAINT [DF_PD_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                   DATETIME         CONSTRAINT [DF_PD_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                 NVARCHAR (50)    CONSTRAINT [DF_PD_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                  INT              CONSTRAINT [DF_PD_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                 ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]              DATETIME         CONSTRAINT [DF_PD_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKProceduresDocument] PRIMARY KEY CLUSTERED ([ProcDocumentId] ASC),
    CONSTRAINT [ProceduresDocumentDocumentCategoryId] FOREIGN KEY ([DocumentCategoryId]) REFERENCES [PolicyProc].[DocumentCategories] ([CategoryId]),
    CONSTRAINT [ProceduresDocumentModifiedByPersonId] FOREIGN KEY ([ModifiedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProceduresDocumentPolicyId] FOREIGN KEY ([PolicyId]) REFERENCES [PolicyProc].[PolicyRegister] ([PolicyId]),
    CONSTRAINT [ProceduresDocumentReviewFrequencyId] FOREIGN KEY ([ReviewFrequencyId]) REFERENCES [PolicyProc].[ReviewFrequency] ([ReviewFrequencyId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UIProceduresDocument]
    ON [PolicyProc].[ProceduresDocument]([DocumentName] ASC);

