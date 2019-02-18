CREATE TABLE [PolicyProc].[ProcedureRegister] (
    [ProcedureId]                           INT              IDENTITY (1, 1) NOT NULL,
    [ProcedureName]                         VARCHAR (255)    NOT NULL,
    [Version]                               DECIMAL (5, 2)   NULL,
    [Status]                                VARCHAR (128)    NULL,
    [SummaryDescription]                    VARCHAR (MAX)    NULL,
    [ProcDocumentId]                        INT              NULL,
    [IsActive]                              BIT              CONSTRAINT [DF_PRO_IA] DEFAULT ((1)) NULL,
    [ModifiedByPersonId]                    SMALLINT         NULL,
    [DocumentationFolderLink]               VARCHAR (2000)   NULL,
    [JoinGUID]                              UNIQUEIDENTIFIER NOT NULL,
    [ProcedureRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_PRO_PORCDT] DEFAULT (getdate()) NOT NULL,
    [ProcedureRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PRO_PORLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                 DATETIME         CONSTRAINT [DF_PRO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                  DATETIME         CONSTRAINT [DF_PRO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                NVARCHAR (50)    CONSTRAINT [DF_PRO_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                 INT              CONSTRAINT [DF_PRO_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]             DATETIME         CONSTRAINT [DF_PRO_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKProcedureRegister] PRIMARY KEY CLUSTERED ([ProcedureId] ASC),
    CONSTRAINT [ProcedureRegisterModifiedByPersonId] FOREIGN KEY ([ModifiedByPersonId]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ProcedureRegisterProcDocumentId] FOREIGN KEY ([ProcDocumentId]) REFERENCES [PolicyProc].[ProceduresDocument] ([ProcDocumentId])
);

