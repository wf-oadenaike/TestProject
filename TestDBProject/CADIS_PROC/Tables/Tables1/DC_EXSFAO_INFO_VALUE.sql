CREATE TABLE [CADIS_PROC].[DC_EXSFAO_INFO_VALUE] (
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
    [CADIS_SYSTEM_INSERTED]  DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME        DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [ActiveStatus]           VARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC)
);

