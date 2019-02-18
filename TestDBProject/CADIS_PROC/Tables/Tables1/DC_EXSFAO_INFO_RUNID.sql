CREATE TABLE [CADIS_PROC].[DC_EXSFAO_INFO_RUNID] (
    [SfAccountId]            VARCHAR (50) NOT NULL,
    [FCAId__RUNID]           INT          NOT NULL,
    [OutletID__RUNID]        INT          NOT NULL,
    [Accountownerid__RUNID]  INT          NOT NULL,
    [AccountName__RUNID]     INT          NOT NULL,
    [BillingStreet__RUNID]   INT          NOT NULL,
    [BillingCity__RUNID]     INT          NOT NULL,
    [BillingPostcode__RUNID] INT          NOT NULL,
    [BillingCountry__RUNID]  INT          NOT NULL,
    [Phone__RUNID]           INT          NOT NULL,
    [ActiveStatus__RUNID]    INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

