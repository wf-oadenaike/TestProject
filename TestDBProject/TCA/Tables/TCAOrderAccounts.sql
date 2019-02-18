CREATE TABLE [TCA].[TCAOrderAccounts] (
    [OrderAccountId]            INT              IDENTITY (1, 1) NOT NULL,
    [OrderId]                   INT              NOT NULL,
    [Account]                   VARCHAR (15)     NULL,
    [TotalShares]               DECIMAL (24, 10) NULL,
    [CADIS_SYSTEM_INSERTED]     DATETIME         CONSTRAINT [DF_TOA_CSI] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]      DATETIME         CONSTRAINT [DF_TOA_CSU] DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY]    NVARCHAR (50)    CONSTRAINT [DF_TOA_CSCB] DEFAULT ('UNKNOWN') NULL,
    [CADIS_SYSTEM_PRIORITY]     INT              CONSTRAINT [DF_TOA_CSP] DEFAULT ((1)) NULL,
    [CADIS_SYSTEM_TIMESTAMP]    ROWVERSION       NOT NULL,
    [CADIS_SYSTEM_LASTMODIFIED] DATETIME         CONSTRAINT [DF_TOA_CSL] DEFAULT (getdate()) NULL,
    CONSTRAINT [PKTCAOrderAccounts] PRIMARY KEY CLUSTERED ([OrderAccountId] ASC)
);

