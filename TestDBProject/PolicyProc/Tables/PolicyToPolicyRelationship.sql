CREATE TABLE [PolicyProc].[PolicyToPolicyRelationship] (
    [PolicyId1]                                      INT              NOT NULL,
    [PolicyId2]                                      INT              NOT NULL,
    [IsActive]                                       BIT              CONSTRAINT [DF_PTPR_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                                       UNIQUEIDENTIFIER NOT NULL,
    [PolicyToPolicyRelationshipCreationDatetime]     DATETIME         CONSTRAINT [DF_PTPR_PTPRCDT] DEFAULT (getdate()) NOT NULL,
    [PolicyToPolicyRelationshipLastModifiedDatetime] DATETIME         CONSTRAINT [DF_PTPR_PTPRLMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                          DATETIME         CONSTRAINT [DF_PTPR_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                           DATETIME         CONSTRAINT [DF_PTPR_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                         NVARCHAR (50)    CONSTRAINT [DF_PTPR_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                          INT              CONSTRAINT [DF_PTPR_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                         ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                      DATETIME         CONSTRAINT [DF_PTPR_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKPolicyToPolicyRelationship] PRIMARY KEY CLUSTERED ([PolicyId1] ASC, [PolicyId2] ASC),
    CONSTRAINT [PolicyToPolicyRelationshipPolicyId1] FOREIGN KEY ([PolicyId1]) REFERENCES [PolicyProc].[PolicyRegister] ([PolicyId]),
    CONSTRAINT [PolicyToPolicyRelationshipPolicyId2] FOREIGN KEY ([PolicyId2]) REFERENCES [PolicyProc].[PolicyRegister] ([PolicyId])
);

