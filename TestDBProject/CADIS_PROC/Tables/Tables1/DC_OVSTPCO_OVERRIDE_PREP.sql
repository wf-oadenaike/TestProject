CREATE TABLE [CADIS_PROC].[DC_OVSTPCO_OVERRIDE_PREP] (
    [SfAccountId]         VARCHAR (18)   NOT NULL,
    [AccountName]         VARCHAR (1000) NULL,
    [WF_PRIMARY_BUSINESS] VARCHAR (1000) NULL,
    [BillingStreet]       VARCHAR (1000) NULL,
    [BillingCity]         VARCHAR (100)  NULL,
    [BillingPostcode]     VARCHAR (100)  NULL,
    [AccountOwnerId]      VARCHAR (18)   NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

