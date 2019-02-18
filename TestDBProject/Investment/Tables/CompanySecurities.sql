CREATE TABLE [Investment].[CompanySecurities] (
    [SecurityBloombergId]               VARCHAR (30)  NOT NULL,
    [CompanyId]                         INT           NOT NULL,
    [CompanySecuritiesCreationDate]     DATETIME      CONSTRAINT [DF_CS_USCD] DEFAULT (getdate()) NOT NULL,
    [CompanySecuritiesLastModifiedDate] DATETIME      CONSTRAINT [DF_CS_USLMD] DEFAULT (getdate()) NOT NULL,
    [CADIS_SYSTEM_INSERTED]             DATETIME      CONSTRAINT [DF_CS_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]              DATETIME      CONSTRAINT [DF_CS_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]            NVARCHAR (50) CONSTRAINT [DF_CS_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]             INT           CONSTRAINT [DF_CS_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]            ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED]         DATETIME      CONSTRAINT [DF_CS_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKCompanySecurities] PRIMARY KEY CLUSTERED ([SecurityBloombergId] ASC),
    CONSTRAINT [InvCompanySecuritiesCompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Investment].[Companies] ([CompanyId])
);

