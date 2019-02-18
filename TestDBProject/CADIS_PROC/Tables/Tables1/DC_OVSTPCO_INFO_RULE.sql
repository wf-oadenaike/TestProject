CREATE TABLE [CADIS_PROC].[DC_OVSTPCO_INFO_RULE] (
    [SfAccountId]               VARCHAR (18) NOT NULL,
    [AccountName__RULEID]       INT          NULL,
    [WFPrimaryBusiness__RULEID] INT          NULL,
    [BillingStreet__RULEID]     INT          NULL,
    [BillingCity__RULEID]       INT          NULL,
    [BillingPostcode__RULEID]   INT          NULL,
    [AccountOwnerId__RULEID]    INT          NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

