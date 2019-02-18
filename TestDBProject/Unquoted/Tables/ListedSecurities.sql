CREATE TABLE [Unquoted].[ListedSecurities] (
    [ListedCompanyId]           INT           NOT NULL,
    [UniqueBloombergId]         VARCHAR (30)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME      CONSTRAINT [DF_LS_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME      CONSTRAINT [DF_LS_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50) CONSTRAINT [DF_LS_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT           CONSTRAINT [DF_LS_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION    NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME      CONSTRAINT [DF_LS_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [XPKListedSecurities] PRIMARY KEY CLUSTERED ([ListedCompanyId] ASC, [UniqueBloombergId] ASC),
    CONSTRAINT [ListedSecuritiesListedCompanyId] FOREIGN KEY ([ListedCompanyId]) REFERENCES [Unquoted].[ListedCompanies] ([ListedCompanyId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_ListedSecurities_UniqueBloombergId]
    ON [Unquoted].[ListedSecurities]([UniqueBloombergId] ASC);

