CREATE TABLE [dbo].[Compliance_KYCPoliticalPosition] (
    [PoliticalPositionID]    INT           IDENTITY (1, 1) NOT NULL,
    [PoliticalPositionName]  VARCHAR (150) NOT NULL,
    [RiskRatingID]           TINYINT       NOT NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT           DEFAULT ('1') NOT NULL,
    CONSTRAINT [PKCompliance_KYCPoliticalPosition] PRIMARY KEY CLUSTERED ([PoliticalPositionID] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [YCRiskRatingID] FOREIGN KEY ([RiskRatingID]) REFERENCES [dbo].[Compliance_KYCRiskRating] ([RiskRatingID])
);

