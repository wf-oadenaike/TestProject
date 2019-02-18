CREATE TABLE [CADIS_PROC].[DC_EXSFAO_INFO_RULE] (
    [SfAccountId]             VARCHAR (50) NOT NULL,
    [FCAId__RULEID]           INT          NULL,
    [OutletID__RULEID]        INT          NULL,
    [Accountownerid__RULEID]  INT          NULL,
    [AccountName__RULEID]     INT          NULL,
    [BillingStreet__RULEID]   INT          NULL,
    [BillingCity__RULEID]     INT          NULL,
    [BillingPostcode__RULEID] INT          NULL,
    [BillingCountry__RULEID]  INT          NULL,
    [Phone__RULEID]           INT          NULL,
    [ActiveStatus__RULEID]    INT          NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC)
);

