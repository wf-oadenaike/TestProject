CREATE TABLE [CADIS_PROC].[DC_OVSTPCO_INFO_RUNID] (
    [SfAccountId]              VARCHAR (18) NOT NULL,
    [AccountName__RUNID]       INT          NOT NULL,
    [WFPrimaryBusiness__RUNID] INT          NOT NULL,
    [BillingStreet__RUNID]     INT          NOT NULL,
    [BillingCity__RUNID]       INT          NOT NULL,
    [BillingPostcode__RUNID]   INT          NOT NULL,
    [AccountOwnerId__RUNID]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

