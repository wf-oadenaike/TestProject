CREATE TABLE [Staging].[SalesteamAccountOverrides] (
    [SfAccountId]            VARCHAR (50)    NOT NULL,
    [FCAId]                  VARCHAR (100)   NOT NULL,
    [OutletID]               VARCHAR (50)    NOT NULL,
    [Accountownerid]         VARCHAR (18)    NOT NULL,
    [AccountName]            NVARCHAR (1000) NOT NULL,
    [BillingStreet]          NVARCHAR (1000) NULL,
    [BillingCity]            NVARCHAR (100)  NULL,
    [BillingPostcode]        NVARCHAR (100)  NOT NULL,
    [BillingCountry]         NVARCHAR (100)  NULL,
    [Phone]                  VARCHAR (50)    NULL,
    [ActiveStatus]           VARCHAR (50)    NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME        CONSTRAINT [DF_STAO_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        CONSTRAINT [DF_STAO_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   CONSTRAINT [DF_STAO_CSCB] DEFAULT ('UNKNOWN') NULL,
    CONSTRAINT [PKSfAccountId] PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

