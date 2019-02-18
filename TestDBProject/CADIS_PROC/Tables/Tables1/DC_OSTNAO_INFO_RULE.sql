CREATE TABLE [CADIS_PROC].[DC_OSTNAO_INFO_RULE] (
    [MatrixOutletID]          VARCHAR (50) NOT NULL,
    [FcaId__RULEID]           INT          NULL,
    [AccountName__RULEID]     INT          NULL,
    [BillingPostcode__RULEID] INT          NULL,
    [AccountownerId__RULEID]  INT          NULL,
    [MakeContact__RULEID]     INT          NULL,
    PRIMARY KEY CLUSTERED ([MatrixOutletID] ASC) WITH (FILLFACTOR = 80)
);

