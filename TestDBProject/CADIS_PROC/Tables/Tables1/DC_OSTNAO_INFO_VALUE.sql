CREATE TABLE [CADIS_PROC].[DC_OSTNAO_INFO_VALUE] (
    [MatrixOutletID]         VARCHAR (50)    NOT NULL,
    [FcaId]                  VARCHAR (100)   NOT NULL,
    [AccountName]            NVARCHAR (1000) NOT NULL,
    [BillingPostcode]        NVARCHAR (100)  NOT NULL,
    [AccountownerId]         VARCHAR (18)    NOT NULL,
    [MakeContact]            BIT             NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    PRIMARY KEY CLUSTERED ([MatrixOutletID] ASC) WITH (FILLFACTOR = 80)
);

