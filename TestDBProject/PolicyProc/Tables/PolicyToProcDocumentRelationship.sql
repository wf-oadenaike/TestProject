CREATE TABLE [PolicyProc].[PolicyToProcDocumentRelationship] (
    [PolicyId]                                             INT              NOT NULL,
    [ProcDocumentId]                                       INT              NOT NULL,
    [IsActive]                                             BIT              CONSTRAINT [DF_PTPDR_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                                             UNIQUEIDENTIFIER NOT NULL,
    [PolicyToProcDocumentRelationshipCreationDatetime]     DATETIME         CONSTRAINT [DF_PTPDR_PTPDRCDT] DEFAULT (getdate()) NOT NULL,
    [PolicyToProcDocumentRelationshipLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PTPDR_PTPDRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                                DATETIME         CONSTRAINT [DF_PTPDR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                                 DATETIME         CONSTRAINT [DF_PTPDR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                               NVARCHAR (50)    CONSTRAINT [DF_PTPDR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                                INT              CONSTRAINT [DF_PTPDR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                               ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                            DATETIME         CONSTRAINT [DF_PTPDR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPolicyToProcDocumentRelationship] PRIMARY KEY CLUSTERED ([PolicyId] ASC, [ProcDocumentId] ASC),
    CONSTRAINT [PolicyToProcDocumentRelationshipPolicyId] FOREIGN KEY ([PolicyId]) REFERENCES [PolicyProc].[PolicyRegister] ([PolicyId]),
    CONSTRAINT [PolicyToProcDocumentRelationshipProcDocumentId] FOREIGN KEY ([ProcDocumentId]) REFERENCES [PolicyProc].[ProceduresDocument] ([ProcDocumentId])
);

