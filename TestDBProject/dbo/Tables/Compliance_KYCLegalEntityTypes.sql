CREATE TABLE [dbo].[Compliance_KYCLegalEntityTypes] (
    [LegalEntityTypeID]      SMALLINT      IDENTITY (1, 1) NOT NULL,
    [LegalEntityType]        VARCHAR (50)  NOT NULL,
    [Acronym]                VARCHAR (50)  NULL,
    [RiskRatingID]           VARCHAR (50)  NULL,
    [CADIS_SYSTEM_INSERTED]  DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_UPDATED]   DATETIME      DEFAULT (getdate()) NULL,
    [CADIS_SYSTEM_CHANGEDBY] NVARCHAR (50) DEFAULT ('UNKNOWN') NULL,
    [IsActive]               BIT           DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PKCompliance_KYCLegalEntityTypes] PRIMARY KEY CLUSTERED ([LegalEntityTypeID] ASC) WITH (FILLFACTOR = 80)
);

