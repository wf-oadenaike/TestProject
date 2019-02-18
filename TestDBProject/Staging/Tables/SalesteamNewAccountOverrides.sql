CREATE TABLE [Staging].[SalesteamNewAccountOverrides] (
    [MatrixOutletID]         VARCHAR (50)    NOT NULL,
    [FcaId]                  VARCHAR (100)   NOT NULL,
    [AccountName]            NVARCHAR (1000) NOT NULL,
    [BillingPostcode]        NVARCHAR (100)  NOT NULL,
    [AccountownerId]         VARCHAR (18)    NOT NULL,
    [MakeContact]            BIT             NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_STNAO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_STNAO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF_STNAO_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKMatrixOutletID] PRIMARY KEY CLUSTERED ([MatrixOutletID] ASC) WITH (FILLFACTOR = 80)
);

