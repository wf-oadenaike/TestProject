CREATE TABLE [CADIS_PROC].[DC_OSTNAO_INFO_RUNID] (
    [MatrixOutletID]         VARCHAR (50) NOT NULL,
    [FcaId__RUNID]           INT          NOT NULL,
    [AccountName__RUNID]     INT          NOT NULL,
    [BillingPostcode__RUNID] INT          NOT NULL,
    [AccountownerId__RUNID]  INT          NOT NULL,
    [MakeContact__RUNID]     INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([MatrixOutletID] ASC) WITH (FILLFACTOR = 80)
);

