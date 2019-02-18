CREATE TABLE [CADIS_PROC].[DC_EXSFAO_ACCOUNT_PREP] (
    [SfAccountId]     NVARCHAR (1000) NOT NULL,
    [FcaId]           NVARCHAR (1000) NULL,
    [MatrixOutletId]  NVARCHAR (1000) NULL,
    [AccountName]     NVARCHAR (1000) NULL,
    [AccountOwnerId]  NVARCHAR (1000) NULL,
    [Phone]           NVARCHAR (1000) NULL,
    [BillingStreet]   NVARCHAR (1000) NULL,
    [BillingCity]     NVARCHAR (1000) NULL,
    [BillingPostcode] NVARCHAR (1000) NULL,
    [BillingCountry]  NVARCHAR (1000) NULL,
    [AccIsActive]     VARCHAR (10)    NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

