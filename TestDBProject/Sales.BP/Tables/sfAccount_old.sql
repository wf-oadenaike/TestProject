CREATE TABLE [Sales.BP].[sfAccount_old] (
    [SfAccountId]          VARCHAR (18)    NOT NULL,
    [AccountName]          NVARCHAR (1000) NULL,
    [FcaId]                VARCHAR (100)   NULL,
    [MatrixOutletId]       VARCHAR (50)    NULL,
    [OutletType]           VARCHAR (100)   NULL,
    [AccountSivId]         VARCHAR (100)   NULL,
    [ParentAccountSivId]   VARCHAR (100)   NULL,
    [AccountOwnerId]       VARCHAR (18)    NULL,
    [Phone]                VARCHAR (50)    NULL,
    [Fax]                  VARCHAR (50)    NULL,
    [Website]              VARCHAR (128)   NULL,
    [EmailAddress]         VARCHAR (128)   NULL,
    [RegionId]             INT             NULL,
    [CalculatedPriority]   DECIMAL (19, 2) NULL,
    [IsKeyAccount]         BIT             NOT NULL,
    [IsPriorityClient]     BIT             NOT NULL,
    [IsLocked]             BIT             CONSTRAINT [c_sa_IsLocked] DEFAULT ('0') NOT NULL,
    [FirmSegment]          VARCHAR (100)   NULL,
    [PlatformsUsed]        VARCHAR (1000)  NULL,
    [AuthStatus]           VARCHAR (100)   NULL,
    [BillingStreet]        NVARCHAR (1000) NULL,
    [BillingCity]          NVARCHAR (100)  NULL,
    [BillingState]         NVARCHAR (100)  NULL,
    [BillingPostcode]      NVARCHAR (100)  NULL,
    [BillingCountry]       NVARCHAR (100)  NULL,
    [ModifiedBy]           VARCHAR (100)   NOT NULL,
    [LastModifiedDatetime] DATETIME        CONSTRAINT [DF_SFA_SFALMDT] DEFAULT (getdate()) NOT NULL,
    [IsActive]             BIT             NOT NULL,
    [StartDatetime]        DATETIME        NOT NULL,
    [EndDatetime]          DATETIME        NOT NULL,
    [SfAccountId_15]       AS              (left([SFAccountId],(15)) collate SQL_Latin1_General_CP1_CS_AS) PERSISTED,
    CONSTRAINT [PKSfAccount] PRIMARY KEY CLUSTERED ([SfAccountId] ASC, [IsActive] ASC, [EndDatetime] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_Acct15]
    ON [Sales.BP].[sfAccount_old]([SfAccountId_15] ASC, [IsActive] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_RegionId]
    ON [Sales.BP].[sfAccount_old]([RegionId] ASC);

