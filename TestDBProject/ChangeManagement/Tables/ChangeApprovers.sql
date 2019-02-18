CREATE TABLE [ChangeManagement].[ChangeApprovers] (
    [ApproverID]                                   INT              IDENTITY (1, 1) NOT NULL,
    [ServiceID]                                    SMALLINT         NOT NULL,
    [ApprovalTypeID]                               SMALLINT         NOT NULL,
    [ApproverPersonID]                             SMALLINT         NOT NULL,
    [JoinGUID]                                     UNIQUEIDENTIFIER NOT NULL,
    [ChangeManagementRegisterCreationDatetime]     DATETIME         CONSTRAINT [DF_CA_CACDT] DEFAULT (getdate()) NOT NULL,
    [ChangeManagementRegisterLastModifiedDatetime] DATETIME         CONSTRAINT [DF_CA_CALMDT] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]                        DATETIME         CONSTRAINT [DF_CA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]                         DATETIME         CONSTRAINT [DF_CA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]                       NVARCHAR (50)    CONSTRAINT [DF_CA_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]                        INT              CONSTRAINT [DF_CA_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]                       ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]                    DATETIME         CONSTRAINT [DF_CA_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKChangeApprovers] PRIMARY KEY CLUSTERED ([ApproverID] ASC),
    CONSTRAINT [ChangeApproversApprovalTypeID] FOREIGN KEY ([ApprovalTypeID]) REFERENCES [ChangeManagement].[ChangeApproversApprovalType] ([ChangeApproversApprovalTypeID]),
    CONSTRAINT [ChangeApproversApproverPersonID] FOREIGN KEY ([ApproverPersonID]) REFERENCES [Core].[Persons] ([PersonId]),
    CONSTRAINT [ChangeApproversServiceID] FOREIGN KEY ([ServiceID]) REFERENCES [ChangeManagement].[ChangeServiceTypes] ([ChangeServiceTypeID])
);

