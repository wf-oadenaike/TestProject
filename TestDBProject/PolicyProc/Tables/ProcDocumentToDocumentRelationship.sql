CREATE TABLE [PolicyProc].[ProcDocumentToDocumentRelationship] (
    [ProcDocumentId1]                                   INT              NOT NULL,
    [ProcDocumentId2]                                   INT              NOT NULL,
    [IsActive]                                          BIT              CONSTRAINT [DF_PDTDR_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                                          UNIQUEIDENTIFIER NOT NULL,
    [ProcDocToDocumentRelationshipCreationDatetime]     DATETIME         CONSTRAINT [DF_PDTDR_PDTDRCDT] DEFAULT (getdate()) NOT NULL,
    [ProcDocToDocumentRelationshipLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PDTDR_PDTDRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                             DATETIME         CONSTRAINT [DF_PDTDR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                              DATETIME         CONSTRAINT [DF_PDTDR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                            NVARCHAR (50)    CONSTRAINT [DF_PDTDR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                             INT              CONSTRAINT [DF_PDTDR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                            ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                         DATETIME         CONSTRAINT [DF_PDTDR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKProcDocumentToDocumentRelationship] PRIMARY KEY CLUSTERED ([ProcDocumentId1] ASC, [ProcDocumentId2] ASC),
    CONSTRAINT [ProcDocumentToDocumentRelationshipProcDocumentId1] FOREIGN KEY ([ProcDocumentId1]) REFERENCES [PolicyProc].[ProceduresDocument] ([ProcDocumentId]),
    CONSTRAINT [ProcDocumentToDocumentRelationshipProcDocumentId2] FOREIGN KEY ([ProcDocumentId2]) REFERENCES [PolicyProc].[ProceduresDocument] ([ProcDocumentId])
);

