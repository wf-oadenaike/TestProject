CREATE TABLE [dbo].[T_MATRIX_SF_ACCOUNT_EXCEPTION] (
    [RowID]                     INT             IDENTITY (1, 1) NOT NULL,
    [Type]                      VARCHAR (50)    NOT NULL,
    [SfAccountId]               VARCHAR (50)    NULL,
    [SfOutletId]                VARCHAR (50)    NULL,
    [MXOutletId]                VARCHAR (50)    NULL,
    [FCAId]                     VARCHAR (100)   NULL,
    [Accountownerid]            VARCHAR (18)    NULL,
    [AccountName]               NVARCHAR (1000) NULL,
    [BillingStreet]             NVARCHAR (1000) NULL,
    [BillingCity]               NVARCHAR (100)  NULL,
    [BillingPostcode]           NVARCHAR (100)  NULL,
    [BillingCountry]            NVARCHAR (100)  NULL,
    [Phone]                     VARCHAR (50)    NULL,
    [ActiveStatus]              VARCHAR (50)    NULL,
    [Sector]                    VARCHAR (10)    NULL,
    [IsPriorityClient]          BIT             NULL,
    [Metrics]                   VARCHAR (20)    NULL,
    [MoveValue]                 DECIMAL (18, 2) NULL,
    [MakeContact]               BIT             NULL,
    [ExportStatus]              VARCHAR (20)    DEFAULT ('WAIT') NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME        CONSTRAINT [DF_T_MATRIX_SF_ACCOUNT_EXCEPTION_CSI] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME        CONSTRAINT [DF_T_MATRIX_SF_ACCOUNT_EXCEPTION_CSU] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)    CONSTRAINT [DF_T_MATRIX_SF_ACCOUNT_EXCEPTION_CSCB] DEFAULT ('UNKNOWN') NOT NULL,
    [CADIS_SYSTEM_PRIORITY]     INT             CONSTRAINT [DF_T_MATRIX_SF_ACCOUNT_EXCEPTION_CSP] DEFAULT ((1)) NOT NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION      NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME        CONSTRAINT [DF_T_MATRIX_SF_ACCOUNT_EXCEPTION_CSL] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([RowID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [IX_T_MATRIX_SF_ACCOUNT_EXCEPTION_SfAccountId_CADIS_SYSTEM_INSERTED]
    ON [dbo].[T_MATRIX_SF_ACCOUNT_EXCEPTION]([SfAccountId] ASC, [CADIS_SYSTEM_INSERTED] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IX_T_MATRIX_SF_ACCOUNT_EXCEPTION_MXOutletId_CADIS_SYSTEM_INSERTED]
    ON [dbo].[T_MATRIX_SF_ACCOUNT_EXCEPTION]([MXOutletId] ASC, [CADIS_SYSTEM_INSERTED] ASC) WITH (FILLFACTOR = 80);

