CREATE TABLE [dbo].[Compliance_KYCCountries] (
    [CountryID]              INT           IDENTITY (1, 1) NOT NULL,
    [RiskRatingID]           TINYINT       NOT NULL,
    [CountryName]            VARCHAR (50)  NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT           DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PKCompliance_KYCCountries] PRIMARY KEY CLUSTERED ([CountryID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [KYCRiskRatingID] FOREIGN KEY ([RiskRatingID]) REFERENCES [dbo].[Compliance_KYCRiskRating] ([RiskRatingID])
);

