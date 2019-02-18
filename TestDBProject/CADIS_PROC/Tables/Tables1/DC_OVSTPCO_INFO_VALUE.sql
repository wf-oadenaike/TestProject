CREATE TABLE [CADIS_PROC].[DC_OVSTPCO_INFO_VALUE] (
    [SfAccountId]               VARCHAR (18)   NOT NULL,
    [AccountName]               VARCHAR (1000) NULL,
    [WFPrimaryBusiness]         VARCHAR (1000) NULL,
    [BillingStreet]             VARCHAR (1000) NULL,
    [BillingCity]               VARCHAR (100)  NULL,
    [BillingPostcode]           VARCHAR (100)  NULL,
    [AccountOwnerId]            VARCHAR (18)   NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME       DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    VARCHAR (50)   DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT            DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([SfAccountId] ASC) WITH (FILLFACTOR = 80)
);

