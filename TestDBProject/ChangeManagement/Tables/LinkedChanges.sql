CREATE TABLE [ChangeManagement].[LinkedChanges] (
    [LinkId]                    INT              IDENTITY (1, 1) NOT NULL,
    [ChangeId1]                 INT              NOT NULL,
    [ChangeId2]                 INT              NOT NULL,
    [IsActive]                  BIT              CONSTRAINT [DF_LC_IA] DEFAULT ((1)) NOT NULL,
    [JoinGUID]                  UNIQUEIDENTIFIER NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_LC_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_LC_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_LC_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_LC_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_LC_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [ChangeManagementLinkedChangesChangeId1] FOREIGN KEY ([ChangeId1]) REFERENCES [ChangeManagement].[ChangeManagementRegister] ([ChangeID]),
    CONSTRAINT [ChangeManagementLinkedChangesChangeId2] FOREIGN KEY ([ChangeId2]) REFERENCES [ChangeManagement].[ChangeManagementRegister] ([ChangeID])
);

