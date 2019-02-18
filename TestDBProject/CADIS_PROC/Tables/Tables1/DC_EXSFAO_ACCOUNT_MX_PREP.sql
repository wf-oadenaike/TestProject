CREATE TABLE [CADIS_PROC].[DC_EXSFAO_ACCOUNT_MX_PREP] (
    [SfAccountId]     VARCHAR (18)   NOT NULL,
    [FcaId]           VARCHAR (20)   NULL,
    [MatrixOutletId]  VARCHAR (50)   NULL,
    [AccountName]     VARCHAR (1000) NULL,
    [AccountOwnerId]  VARCHAR (18)   NULL,
    [Phone]           VARCHAR (50)   NULL,
    [BillingStreet]   VARCHAR (1000) NULL,
    [BillingCity]     VARCHAR (100)  NULL,
    [BillingPostcode] VARCHAR (100)  NULL,
    [BillingCountry]  VARCHAR (100)  NULL,
    [MFidStatus]      VARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

